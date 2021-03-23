using UnityEngine;
using System.Collections;
using OpenCvSharp;
using OpenCvSharp.CPlusPlus;

using System.Collections.Generic;
using System.Linq;
using System;

public class PositionManager : HimeLib.SingletonMono<PositionManager>
{
    [Header("攝影機設定 (翻轉)")]
    public bool flipY = false;

    [Header("場景長寬 (Unity 單位), 輸出轉換用 , 濾掉不要的部分高")]
    public float sceneWidth = 10;
    public float sceneHeight = 5;
    // public int noUseHeight = 20;
    // public float YFractor = 2;

    [Header("偵測高度, 多少高度會被視為人")]
    [Range(1, 255)] public float detectThreshold = 30f;

    [Header("判定規則 (基礎大小, 容許誤差, 基礎形狀比, 容許誤差) , 在4公尺高時的基礎大小建議值為1200")]
    public int acceptRect = 1200;
    public int acceptRectAllowance = 800;
    [Range(0.01f, 5f)] public float acceptRatio = 1.0f;
    [Range(0, 2)] public float acceptRatioAllowance = 0.5f;

    [Header("最終輸出點,可直接存取")]
    public List<Vector3> UnityDetectResult = new List<Vector3>();


    //影像處理變數
    int frameCount = 0;             //已經過frame

    Mat imgPrevious = new Mat();    //上一張圖
    Mat imgNext = new Mat();        //下一張圖
    Mat imgWork = new Mat();       //作業1
    Mat imgBinary;                  //二元圖

    //new Mat (webcam.height, webcam.width, MatType.CV_8UC4);  //Mat 建立範例

    //open CV 用
    Size size3, size5, size7, size15;
    Mat structuringElement3x3, structuringElement5x5, structuringElement7x7, structuringElement15x15;

    //所有觀眾座標資料
    List<Blob> AvaliableBlobs = new List<Blob>();
    List<Blob> currentFrameBlobs = new List<Blob>();

    Mat TextureToCVMat(Texture2D texData)
    {
        int width = texData.width;
        int height = texData.height;
        //8UC3 意思是 8bit unsigned char , 共3個 , 也就是 TextureFormat.RGB24
        Mat mat = new Mat(height, width, MatType.CV_8UC3, texData.GetRawTextureData());
        Cv2.CvtColor(mat, mat, ColorConversion.BgrToRgb);

        //由於是Kinect原圖的關係, 所以不用翻轉, 不然其他圖片'應該'翻轉
        //Cv2.Flip(mat, mat, FlipMode.X);

        return mat;
    }

    void InitStructuringElement()
    {
        size3 = new Size(3, 3);
        size5 = new Size(5, 5);
        size7 = new Size(7, 7);
        size15 = new Size(15, 15);
        structuringElement3x3 = Cv2.GetStructuringElement(StructuringElementShape.Rect, size3);
        structuringElement5x5 = Cv2.GetStructuringElement(StructuringElementShape.Rect, size5);
        structuringElement7x7 = Cv2.GetStructuringElement(StructuringElementShape.Rect, size7);
        structuringElement15x15 = Cv2.GetStructuringElement(StructuringElementShape.Rect, size15);
    }

    IEnumerator Start()
    {
        InitStructuringElement();

        while (!InfraredSourceManager.instance.isReady)
            yield return null;

        // EncodeToPNG 很慢!!!
        //imgPrevious = Mat.FromImageData(texComing.EncodeToPNG());
        //imgNext = Mat.FromImageData(texComing.EncodeToPNG());
        imgNext = TextureToCVMat(InfraredSourceManager.instance.GetInfraredTexture());

        InfraredSourceManager.instance.OnNewTextureArrived += ProccessTexture;
    }

    void ProccessTexture(Texture2D tex)
    {
        //Update tex data
        imgPrevious = imgNext;
        imgNext = TextureToCVMat(tex);
        if (flipY) Cv2.Flip(imgNext, imgNext, FlipMode.Y);  //攝影機翻轉,依展場需求

        //Clear Blob Infomation for next frame
        currentFrameBlobs.Clear();

        //開啟作業區
        imgWork = imgNext.Clone();
        // Cv2.ImShow("coming", imgNext);

        //必要步驟1. 變成黑白
        Cv2.CvtColor(imgWork, imgWork, ColorConversion.BgrToGray);

        //必要步驟2. 高斯模糊
        //Size size = new Size(5, 5);
        //Cv2.GaussianBlur(imgWork1, imgWork1, size, 0);

        //二元法，低於Threshold是0，高於Threshold是 255
        imgBinary = new Mat();
        Cv2.Threshold(imgWork, imgBinary, detectThreshold, 255.0, ThresholdType.Binary);
        //Cv2.ImShow("imgBinary", imgBinary);

        //擴張，縮小 二元影像
        for (int i = 0; i < 2; i++)
        {
            Cv2.Dilate(imgBinary, imgBinary, structuringElement7x7);
            Cv2.Erode(imgBinary, imgBinary, structuringElement5x5);
        }

        Mat imgBinaryCopy = imgBinary.Clone();
        // Cv2.ImShow("imgThresh2", imgBinaryCopy);

        //開始抓輪廓
        Point[][] contourPointGroup;
        HierarchyIndex[] hierarchyIndexes;
        Cv2.FindContours(imgBinaryCopy, out contourPointGroup, out hierarchyIndexes, ContourRetrieval.External, ContourChain.ApproxSimple, null);
        //drawAndShowContours(imgBinaryCopy.Size(), contourPointGroup, "imgContours");

        //每個contourpp 群組 分給 contourss
        List<List<Point>> contourWork = new List<List<Point>>();
        for (int i = 0; i < contourPointGroup.Length; i++)
        {
            List<Point> ppp = new List<Point>();
            for (int j = 0; j < contourPointGroup[i].Length; j++)
            {
                ppp.Add(contourPointGroup[i][j]);
            }
            contourWork.Add(ppp);
        }
        Point[][] convexHulls = new Point[contourPointGroup.Length][];
        for (int i = 0; i < contourPointGroup.Length; i++)
        {
            List<Point> contoursp = contourWork[i];
            IEnumerable<Point> contourse = contoursp;
            convexHulls[i] = Cv2.ConvexHull(contourse);
        }

        //2019.06.25 畫出區塊
        drawAndShowContours(imgBinary.Size(), convexHulls, "imgConvexHulls");

        foreach (Point[] item in convexHulls)
        {
            //宣告出一個泡泡, 泡泡會初始化各種必要內容
            Blob possibleBlob = new Blob(item);

            // Blob 介於某個指定參數的+-某值時, 該Blob生效
            if (possibleBlob.blobArea < acceptRect + acceptRectAllowance &&
                possibleBlob.blobArea > acceptRect - acceptRectAllowance &&
                possibleBlob.dblCurrentAspectRatio < acceptRatio + acceptRatioAllowance &&
                possibleBlob.dblCurrentAspectRatio > acceptRatio - acceptRatioAllowance)
            {
                currentFrameBlobs.Add(possibleBlob);
                //Debug.Log("泡泡寬度: " + possibleBlob.blobArea + " , 長寬比: " + possibleBlob.dblCurrentAspectRatio);
            }
        }

        //把來源的座標轉換為Unity世界座標
        AvaliableBlobs.Clear();
        AvaliableBlobs.AddRange(currentFrameBlobs);

        UnityDetectResult.Clear();
        foreach (var item in AvaliableBlobs)
        {
            //CV跟Unity 中心座標不一樣、Y值正方向座標不一樣
            Vector3 rawPoint = item.BaseCenterPoint;
            float _x = (rawPoint.x / tex.width) * (sceneWidth * 2) - sceneWidth;
            float _y = -((rawPoint.y / tex.height) * (sceneHeight * 2) - sceneHeight);

            UnityDetectResult.Add(new Vector3(_x, 0, _y));
        }

        //2019.06.25 測試用
        //get another copy of frame 2 since we changed the previous frame 2 copy in the processing above
        Mat imgTempShow = imgNext.Clone();
        DrawBlobInfoOnMat(AvaliableBlobs, imgTempShow);
        Cv2.ImShow("ResultDetect", imgTempShow);

        //重設目前Frame 存在的人
        currentFrameBlobs.Clear();

        frameCount++;
    }
    public void DrawBlobInfoOnMat(List<Blob> blobs, Mat imgFrame2Copy)
    {
        for (int i = 0; i < blobs.Count; i++)
        {
            Point targetPoint = new Point(blobs[i].BaseCenterPoint.x, blobs[i].BaseCenterPoint.y);
            Vector2 targetVector = new Vector2(targetPoint.X, targetPoint.Y);

            Cv2.Rectangle(imgFrame2Copy, blobs[i].currentBoundingRect, PMUtility.SCALAR_RED, 2);
            Cv2.Circle(imgFrame2Copy, targetPoint.X, targetPoint.Y, 3, PMUtility.SCALAR_GREEN, 1);
        }
    }

    public class PMUtility
    {
        public static Scalar SCALAR_BLACK = new Scalar(0.0, 0.0, 0.0);
        public static Scalar SCALAR_WHITE = new Scalar(255.0, 255.0, 255.0);
        public static Scalar SCALAR_YELLOW = new Scalar(0.0, 255.0, 255.0);
        public static Scalar SCALAR_GREEN = new Scalar(0.0, 200.0, 0.0);
        public static Scalar SCALAR_RED = new Scalar(0.0, 0.0, 255.0);
    }








































    ///////////////////////////////////////////////////////////////////////////////////////////////////
    public void matchCurrentFrameBlobsToExistingBlobs(List<Blob> existingBlobs, List<Blob> currentFrameBlobs)
    {

        foreach (Blob existingBlob in existingBlobs)
        {
            existingBlob.blnCurrentMatchFoundOrNewBlob = false;
            //existingBlob.predictNextPosition();
        }

        foreach (Blob currentFrameBlob in currentFrameBlobs)
        {
            int intIndexOfLeastDistance = 0;
            double dblLeastDistance = 100000.0;

            for (int i = 0; i < existingBlobs.Count; i++)
            {
                if (existingBlobs[i].blnStillBeingTracked == true)
                {
                    double dblDistance = distanceBetweenPoints(currentFrameBlob.centerPositions[currentFrameBlob.centerPositions.Count - 1], existingBlobs[i].predictedNextPosition);

                    if (dblDistance < dblLeastDistance)
                    {
                        dblLeastDistance = dblDistance;
                        intIndexOfLeastDistance = i;
                    }
                }
            }

            if (dblLeastDistance < currentFrameBlob.dblCurrentDiagonalSize * 0.5)
            {
                //  Debug.Log("in");
                addBlobToExistingBlobs(currentFrameBlob, existingBlobs, intIndexOfLeastDistance);
            }
            else
            {
                //Debug.Log("innew");
                addNewBlob(currentFrameBlob, existingBlobs);
            }
        }

        foreach (Blob existingBlob in existingBlobs)
        {
            if (existingBlob.blnCurrentMatchFoundOrNewBlob == false)
            {
                existingBlob.intNumOfConsecutiveFramesWithoutAMatch++;
                //Debug.Log(existingBlob.intNumOfConsecutiveFramesWithoutAMatch);
            }

            if (existingBlob.intNumOfConsecutiveFramesWithoutAMatch >= 50)
            {
                existingBlob.intNumOfConsecutiveFramesWithoutAMatch = 0;
                existingBlob.blnStillBeingTracked = false;
            }
        }
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    public void addBlobToExistingBlobs(Blob currentFrameBlob, List<Blob> existingBlobs, int intIndex)
    {

        existingBlobs[intIndex].currentContour = currentFrameBlob.currentContour;
        existingBlobs[intIndex].currentBoundingRect = currentFrameBlob.currentBoundingRect;

        existingBlobs[intIndex].centerPositions.Add(currentFrameBlob.centerPositions[currentFrameBlob.centerPositions.Count - 1]);

        existingBlobs[intIndex].dblCurrentDiagonalSize = currentFrameBlob.dblCurrentDiagonalSize;
        existingBlobs[intIndex].dblCurrentAspectRatio = currentFrameBlob.dblCurrentAspectRatio;

        existingBlobs[intIndex].blnStillBeingTracked = true;
        existingBlobs[intIndex].blnCurrentMatchFoundOrNewBlob = true;
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    public void addNewBlob(Blob currentFrameBlob, List<Blob> existingBlobs)
    {
        currentFrameBlob.blnCurrentMatchFoundOrNewBlob = true;
        existingBlobs.Add(currentFrameBlob);
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    public double distanceBetweenPoints(Point point1, Point point2)
    {
        int intX = Mathf.Abs(point1.X - point2.X);
        int intY = Mathf.Abs(point1.Y - point2.Y);

        return (Mathf.Sqrt(Mathf.Pow(intX, 2) + Mathf.Pow(intY, 2)));
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    public void drawAndShowContours(Size imageSize, IEnumerable<IEnumerable<Point>> contours, string strImageName)
    {
        Mat image = new Mat(imageSize, MatType.CV_8UC3, PMUtility.SCALAR_BLACK);

        Cv2.DrawContours(image, contours, -1, PMUtility.SCALAR_WHITE, -1);

        Cv2.ImShow(strImageName, image);
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    public void drawAndShowContours(Size imageSize, List<Blob> blobs, string strImageName)
    {
        Mat image = new Mat(imageSize, 0, PMUtility.SCALAR_BLACK);
        List<Point[]> contourslist = new List<Point[]>();

        int i = 0;
        foreach (Blob blob in blobs)
        {
            if (blob.blnStillBeingTracked == true)
            {
                contourslist.Add(blob.currentContour);
                //contourslist.Add(blob.currentContour);
                //contours = contours.Concat(new[] { new IEnumerable<Point>("msg2") })
            }
            i++;
        }
        int num = contourslist.Count;
        Point[][] contourslistt = new Point[num][];
        for (int k = 0; k < num; k++)
        {
            contourslistt[k] = contourslist[k];

        }
        // IEnumerable<IEnumerable<Point>> contours = contourslist as IEnumerable<IEnumerable<Point>>;
        Cv2.DrawContours(image, contourslistt, -1, PMUtility.SCALAR_WHITE, -1);
        Cv2.ImShow(strImageName, image);
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    public bool checkIfBlobsCrossedTheLine(List<Blob> blobs, int intHorizontalLinePosition, int carCount)
    {
        bool blnAtLeastOneBlobCrossedTheLine = false;
        foreach (Blob blob in blobs)
        {
            if (blob.blnStillBeingTracked == true && blob.centerPositions.Count >= 2)
            {
                int prevFrameIndex = (int)blob.centerPositions.Count - 2;
                int currFrameIndex = (int)blob.centerPositions.Count - 1;
                if (blob.centerPositions[prevFrameIndex].Y > intHorizontalLinePosition && blob.centerPositions[currFrameIndex].Y <= intHorizontalLinePosition)
                {
                    carCount++;
                    blnAtLeastOneBlobCrossedTheLine = true;
                }
            }
        }
        return blnAtLeastOneBlobCrossedTheLine;
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    public void drawCarCountOnImage(int carCount, Mat imgFrame2Copy)
    {
        //int intFontFace = 0;
        double dblFontScale = (imgFrame2Copy.Rows * imgFrame2Copy.Cols) / 300000.0;
        // int intFontThickness = (int)Mathf.Round(dblFontScale * 1.5f);

        int resultInt = 0;
        Size textSize = Cv2.GetTextSize(carCount.ToString(), 0, dblFontScale, 0, out resultInt);

        Point ptTextBottomLeftPosition;

        ptTextBottomLeftPosition.X = imgFrame2Copy.Cols - 1 - (int)((double)textSize.Width * 1.25);

        ptTextBottomLeftPosition.Y = (int)((double)textSize.Height * 1.25);

        Cv2.PutText(imgFrame2Copy, carCount.ToString(), ptTextBottomLeftPosition, 0, dblFontScale, PMUtility.SCALAR_GREEN, 1);
    }
}

