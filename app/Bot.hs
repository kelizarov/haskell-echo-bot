module Bot where

import           Telegram.Data
import           Telegram.API
import           Control.Monad
import           Ext.Data.List                  ( list )

runBot :: IO ()
-- start getMessages with 0 offset
-- recursively call runBot with an offset received after getMessages
runBot = getMessages 0 >> pure ()

getMessages :: Int -> IO Int
-- get recent messages
-- handle each message to handleMessage
-- return update_id
getMessages offset = do
    rsp <- getUpdates offset
    either left right rsp
  where
    left errorMsg = print errorMsg >> getMessages offset
    right updateResponse = mapM_ handleUpdate updates
        >> getMessages (getNextOffset $ updates)
        where 
            updates = updateResponseResult updateResponse

getNextOffset :: [Update] -> Int
getNextOffset xs = list 0 ((+ 1) . last) $ fmap updateUpdateId xs

handleUpdate :: Update -> IO ()
-- parse message
-- if starts with / handle as command
-- otherwise echo fun
handleUpdate upd = print "Handle update: " >> print upd

