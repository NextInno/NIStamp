package ni.module.config;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

import org.apache.log4j.Appender;
import org.apache.log4j.PatternLayout;
import org.apache.log4j.RollingFileAppender;
import org.apache.log4j.Logger;
import org.apache.log4j.Level;

public class NiModuleConfig {
	
	private static final Logger logger = Logger.getLogger( NiModuleConfig.class.getName() );
	
	// 싱글톤을 위함. 자바 디자인패턴을 읽어 보도록
	public static NiModuleConfig getInstance() {
		if( niModuleConfig == null )
			niModuleConfig = new NiModuleConfig();
		return niModuleConfig;
	}
	
    //////////////////////////////
    // [logs]
	private String logLevel = "";
	private String logPath = "";
	private int logMaxFileSize = 0;
	private int logMaxBackupIndex = 0;
	
	// 아래의 설정은 프로젝트마다 필요한 것으로 교체하도록 한다.
	
	//////////////////////////////
	// [web server] 

	private String SERVER_IP = "";
	private int SERVER_PORT = 0;
	
	//////////////////////////////
	// [DB server] 
	
	private String DB_SERVER_IP = "";
//	private int DB_PASSWORD = 0;
	private String DB_ID = "";
	private String DB_PASSWORD = "";
	
	//////////////////////////////
	// [file]	
	// ni.conf 는 nixxx.conf로 하고, xxx는 프로젝트명으로 한다.
	//C:\java\workspace\NI_Module_Jsp_Servlet_log4j_config\logs
	private String configFileName = "C:\\Users\\raesung\\git\\NIStamp\\conf\\ni.conf";

	// bwps.conf 
	private static Properties propConf = null;
	
	private static NiModuleConfig niModuleConfig = null;
	
	private NiModuleConfig()
	{
		System.out.println("in NiModuleConfig...");
		loadNiConf();
		System.out.println("in loadNiConf...");
		setNiConfValue();
		System.out.println("in setNiConfValue...");
	}
	
	/**
	 * ni.conf 
	 * file Load
	 */
	private void loadNiConf()
	{
	    FileInputStream fis;
	    
	    try
        {
	        propConf = new Properties();
	        	        
            fis = new FileInputStream( configFileName );
            
            propConf.load( fis );
            
            fis.close();
        }
        catch( FileNotFoundException e )
        {
        	logger.error("FileNotFoundException", e);
        }
        catch( IOException e )
        {
        	logger.error("IOException", e);
        }
	}
	
	/**
	 * propConf 
	 * 파일에 저장되어 있는 key의 값을 가져온다.
	 */
	private void setNiConfValue()
	{
//		필요한 건 위에 선언하고 get만들어서 사용
		SERVER_IP = getConfig( "SERVER_IP" );
		SERVER_PORT = getIntConfig( "SERVER_PORT" );
				
		DB_SERVER_IP = getConfig( "DB_SERVER_IP" );
		DB_ID = getConfig( "DB_ID" );
		DB_PASSWORD = getConfig( "DB_PASSWORD" );
        
        logLevel = getConfig( "LogLevel" );
        logPath = getConfig( "LogPath" );
        logMaxFileSize = getIntConfig( "LogMaxFileSize" );
        logMaxBackupIndex = getIntConfig( "LogMaxBackupIndex" );
	}
	
	/**
	 * @param fileName
	 * @param maxFileSize
	 * @param maxBackupIndex
	 * @return
	 */
	private static Appender getAppender(String fileName, int maxFileSize, int maxBackupIndex) 
	{
		RollingFileAppender appender = null;
		
		try 
		{
			appender = new RollingFileAppender(new PatternLayout("%-5p | %d{yyyy-MM-dd HH:mm.ss.SSS} | %l[%t] | %m%n"), fileName);		
			appender.setMaxFileSize(maxFileSize + "MB");
			appender.setMaxBackupIndex(maxBackupIndex);
		}
		catch (IOException e) 
		{
			logger.error( "Could not create appender for " + fileName, e );
		}
		
		return appender;
	}
	
	
    /**
     * setLogger
     */
    public static void setLogger()
    {
        String logLevel = NiModuleConfig.getInstance().getLogLevel();
        
        if(logLevel.equals("DEBUG")) {
            Logger.getRootLogger().setLevel(Level.DEBUG);                   
        } else if(logLevel.equals("INFO")) {
            Logger.getRootLogger().setLevel(Level.INFO);
        } else if(logLevel.equals("WARN")) {
            Logger.getRootLogger().setLevel(Level.WARN);
        } else if(logLevel.equals("ERROR")) {
            Logger.getRootLogger().setLevel(Level.ERROR);
        } else if(logLevel.equals("FATAL")) {
            Logger.getRootLogger().setLevel(Level.FATAL);
        }
        else
        {
            Logger.getRootLogger().setLevel(Level.INFO);
        }
        
        String logPath = NiModuleConfig.getInstance().getLogPath();
   
        int logMaxFileSize = NiModuleConfig.getInstance().getLogMaxFileSize();
        
        int logMaxBackupIndex = NiModuleConfig.getInstance().getLogMaxBackupIndex();
        System.out.println("logPath : " + logPath);
        Logger.getRootLogger().addAppender(getAppender( logPath + "/ni.log", logMaxFileSize, logMaxBackupIndex ));
        
    }
	
	/**
	 * @param key : file의 key 값
	 * @return
	 * key의 값이 int인 경우
	 */
	public int getIntConfig( String key )
	{
	    int retValue = -1;
	    
	    if( propConf.get( key ) != null )
	    {
	        retValue = Integer.valueOf( propConf.getProperty( key ) );
	    }
	    
	    return retValue;
	}
	
	/**
	 * @param key : file의 key 값
	 * @return
	 * key의 값이 string인 경우
	 */
	public String getConfig( String key )
	{
	    String retValue    = "";
        
        if( propConf.get( key ) != null )
        {
            retValue = propConf.getProperty( key );
        }
        
        return retValue;
	}
	
    //////////////////////////////
    // Getter
	
    /**
     * @return the logLevel
     */
    public String getLogLevel()
    {
        return logLevel;
    }

    /**
     * @return the logPath
     */
    public String getLogPath()
    {
        return logPath;
    }

    /**
     * @return the logMaxFileSize
     */
    public int getLogMaxFileSize()
    {
        return logMaxFileSize;
    }

    /**
     * @return the logMaxBackupIndex
     */
    public int getLogMaxBackupIndex()
    {
        return logMaxBackupIndex;
    }
    
    /**
     * @return the SERVER_IP
     */
    public String getSERVER_IP() 
    {
		return SERVER_IP;
	}

	/**
	 * @return the SERVER_PORT
	 */
	public int getSERVER_PORT() 
	{
		return SERVER_PORT;
	}
	
	/**
	 * @return the DB_ID
	 */
	public String getDB_ID() {
		return DB_ID;
	}

	/**
	 * @return the DB_PASSWORD
	 */
	public String getDB_PASSWORD() {
		return DB_PASSWORD;
	}

	/**
	 * @return get DB_SERVER_IP
	 */
	public String getDB_SERVER_IP() {
		return DB_SERVER_IP;
	}

	/**
	 * @param set dB_SERVER_IP
	 */
	public void setDB_SERVER_IP(String dB_SERVER_IP) {
		DB_SERVER_IP = dB_SERVER_IP;
	}

}
