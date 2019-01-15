module Main where

import           Bot

-- mainLoop :: IO ()
-- mainLoop = do
--     rsp <-
--         try (getUpdates Nothing) :: IO
--             (Either SomeException (Maybe UpdateResponse))
--     case rsp of
--         Right r -> case r of
--             Just rs ->
--                 let updateIds = (fmap updateUpdateId . updateResponseResult) rs
--                     chatIds =
--                         ( fmap chatId
--                             . fmap messageChat
--                             . catMaybes
--                             . fmap updateMessage
--                             . updateResponseResult
--                             )
--                             rs
--                 in  case updateIds of
--                         [] -> print "Empty update ids"
--                         ids ->
--                             getUpdates (list Nothing (Just . last) ids)
--                                 >> sendMessage (list 0 last chatIds) "Hello"
--                                 >> pure ()
--             Nothing -> print "No data can be shown"
--         Left ex ->
--             putStrLn $ "Error occured when getting updates: \n" ++ show ex

main :: IO ()
main = runBot
