{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module Utils where

import           Control.Monad.IO.Class (MonadIO)
import           Control.Monad.Reader   (MonadReader)
import           System.IO (hPutStrLn, stderr)
import           System.Exit (exitFailure)
import           Types

{-
verbose :: (MonadReader SparkConfig m, MonadIO m) => String -> m ()
verbose str = do
    v <- asks conf_verbose
    if v
    then liftIO $ putStrLn str
    else return ()

verboseOrDry :: (MonadReader SparkConfig m, MonadIO m) => String -> m ()
verboseOrDry str = do
    v <- asks conf_verbose
    d <- asks conf_dry
    if v || d
    then liftIO $ putStrLn str
    else return ()
-}

debug :: (MonadReader SparkConfig m, MonadIO m) => String -> m ()
debug str = do
    v <- asks conf_debug
    if v
    then liftIO $ putStrLn str
    else return ()


incase :: MonadReader SparkConfig m => (SparkConfig -> Bool) -> m () -> m ()
incase bf func = do
    b <- asks bf
    if b
    then func
    else return ()

incaseElse :: MonadReader SparkConfig m => (SparkConfig -> Bool) -> m a -> m a -> m a
incaseElse bf funcif funcelse = do
    b <- asks bf
    if b
    then funcif
    else funcelse

notImplementedYet :: Sparker ()
notImplementedYet = throwError $ UnpredictedError "This feature is not implemented yet, it will be in the future, so be sure to check back in a newer version."

die :: String -> IO a
die err = hPutStrLn stderr err >> exitFailure
