using UnityEngine;
using System.Collections;
using Windows.Kinect;

public class InfraredSourceManager : HimeLib.SingletonMono<InfraredSourceManager> 
{
    private KinectSensor _Sensor;
    private DepthFrameReader _Reader;
    private ushort[] _Data;
    private byte[] _RawData;

    private const int MapDepthToByte = 8000 / 256;
    ushort minDistance;
    ushort maxDistance;
    ushort mapDepthToByte;
    
    // I'm not sure this makes sense for the Kinect APIs
    // Instead, this logic should be in the VIEW
    private Texture2D _Texture;

    public Texture2D GetInfraredTexture()
    {
        return _Texture;
    }
    public bool isReady {get; private set;}

    public System.Action<Texture2D> OnNewTextureArrived;
    
    void Start()
    {
        _Sensor = KinectSensor.GetDefault();
        if (_Sensor != null) 
        {
            _Reader = _Sensor.DepthFrameSource.OpenReader();
            
            var frameDesc = _Sensor.DepthFrameSource.FrameDescription;
            _Data = new ushort[frameDesc.LengthInPixels];
            _RawData = new byte[frameDesc.LengthInPixels * 4];
            _Texture = new Texture2D(frameDesc.Width, frameDesc.Height, TextureFormat.RGB24, false);

            minDistance = _Sensor.DepthFrameSource.DepthMinReliableDistance;
            maxDistance = _Sensor.DepthFrameSource.DepthMaxReliableDistance;
            mapDepthToByte = (ushort) (maxDistance / 256);

            Debug.Log($"depth:{frameDesc.Width},{frameDesc.Height},{frameDesc.LengthInPixels}\nmin: {minDistance}, max: {maxDistance}");
            
            if (!_Sensor.IsOpen)
            {
                _Sensor.Open();
            }
        }
    }

    void Update () 
    {
        if (_Reader != null) 
        {
            var frame = _Reader.AcquireLatestFrame();

            if (frame != null)
            {
                frame.CopyFrameDataToArray(_Data);
                
                int index = 0;
                foreach(ushort ir in _Data)
                {
                    //byte intensity = (byte)(ir >> 8);

                    // byte intensity = 0;
                    // if(ir <= minDistance)
                    //     intensity = 0;
                    // else if (ir >= maxDistance)
                    //     intensity = 255;
                    // else
                    //     intensity = (byte)(ir / MapDepthToByte);

                    byte intensity = (byte)(ir >= minDistance && ir <= maxDistance ? (ir / mapDepthToByte) : 255);

                    _RawData[index++] = (byte) (255 - intensity);
                    _RawData[index++] = (byte) (255 - intensity);
                    _RawData[index++] = (byte) (255 - intensity);
                    //_RawData[index++] = 255; // Alpha
                }
                
                _Texture.LoadRawTextureData(_RawData);
                _Texture.Apply();

                OnNewTextureArrived?.Invoke(_Texture);

                frame.Dispose();
                frame = null;

                isReady = true;
            }
        }
    }
    
    void OnApplicationQuit()
    {
        if (_Reader != null) 
        {
            _Reader.Dispose();
            _Reader = null;
        }
        
        if (_Sensor != null) 
        {
            if (_Sensor.IsOpen)
            {
                _Sensor.Close();
            }
            
            _Sensor = null;
        }
    }
}
