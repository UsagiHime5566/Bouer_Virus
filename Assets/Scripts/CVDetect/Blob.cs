using UnityEngine;
using System.Collections;
using OpenCvSharp;
using OpenCvSharp.CPlusPlus;
using System.Collections.Generic;

public class Blob {
    // Blob原始資料
    public Point[] currentContour;

    // 所在矩形範圍
    public OpenCvSharp.CPlusPlus.Rect currentBoundingRect;

    // 矩形面積
    public int blobArea;

    //中心點
    public Vector2 BaseCenterPoint = Vector2.zero;

    //對角線長度
    public double dblCurrentDiagonalSize;

    //長寬比
    public double dblCurrentAspectRatio;



    // ??????
    public List<Point> centerPositions = new List<Point>();
    public bool blnCurrentMatchFoundOrNewBlob;
    public bool blnStillBeingTracked;
    public int intNumOfConsecutiveFramesWithoutAMatch;
    public Point predictedNextPosition;


    //CV座標   X  --->
    //      Y
    //      |
    //      v
    //長寬限制 = webcam 長寬 , 本次範例 720 * 480
    public Blob(Point[] _contour)
    {
        currentContour = _contour;
        currentBoundingRect = Cv2.BoundingRect(currentContour);

        //所在矩形面積
        blobArea = currentBoundingRect.Width * currentBoundingRect.Height;
        
        //2019.06.25 新中心點 Vector2
        float c_x = currentBoundingRect.X + (currentBoundingRect.Width / 2.0f);
        float c_y = currentBoundingRect.Y + (currentBoundingRect.Height / 2.0f);
        BaseCenterPoint = new Vector2(c_x, c_y);
    
        //Debug.Log("currentBoundingRect.x : " + BaseCenterPoint.x + "  currentBoundingRect.y :" + BaseCenterPoint.y);

        //對角線長度
        dblCurrentDiagonalSize = Mathf.Sqrt(Mathf.Pow(currentBoundingRect.Width, 2) + Mathf.Pow(currentBoundingRect.Height, 2));
        //寬為1時，長度為寬的幾倍 = X_Ration 倍率
        dblCurrentAspectRatio = (float)currentBoundingRect.Width / (float)currentBoundingRect.Height;


        // ????
        //追蹤用
        blnStillBeingTracked = true;
        blnCurrentMatchFoundOrNewBlob = true;

        //拋棄過期點 Counter , 使用於這個點過久沒被更新的話，將這個點拋棄
        intNumOfConsecutiveFramesWithoutAMatch = 0;
    }
}
