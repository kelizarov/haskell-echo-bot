{-# LANGUAGE OverloadedStrings #-}

module Telegram.API where

import           Telegram.Data
import           Control.Exception
import           Data.Aeson
import qualified Data.Text                     as T
import qualified Data.ByteString.Char8         as B
import           Network.HTTP.Req
import           Data.Default.Class
import           Data.Maybe
import           Control.Exception


token :: T.Text
token = "442268138:AAF4C2O7daFjZdCrbHY7DNJlQqnSIURnNvg"

host :: T.Text
host = "api.telegram.org"

getUpdates :: Int -> IO (Either String UpdateResponse)
getUpdates offset = do
    rsp <- try $ runReq
        def
        (  req GET
               (https host /: ("bot" <> token) /: "getUpdates")
               NoReqBody
               lbsResponse
        $  "offset"
        =: offset
        )
    pure $ either left right rsp
  where
    left :: SomeException -> Either String a
    left httpException = Left $ show httpException
    right = eitherDecode . responseBody


sendMessage :: Int -> T.Text -> IO B.ByteString
sendMessage chatId text = do
    let requestBody = SendMessage chatId text
    bs <- runReq def $ req POST
                           (https host /: ("bot" <> token) /: "sendMessage")
                           (ReqBodyJson requestBody)
                           bsResponse
                           mempty
    return (responseBody bs)

