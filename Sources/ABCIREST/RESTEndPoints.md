#  REST interface info



## 

```
curl http://192.168.64.1:26657
```

### Available endpoints:

//192.168.64.1:26657/abci_info?
//192.168.64.1:26657/abci_query?path=_&data=_&height=_&prove=_
//192.168.64.1:26657/block?height=_
//192.168.64.1:26657/block_by_hash?hash=
//192.168.64.1:26657/block_results?height=_
//192.168.64.1:26657/blockchain?minHeight=_&maxHeight=_
//192.168.64.1:26657/broadcast_evidence?evidence=_
//192.168.64.1:26657/broadcast_tx_async?tx=_
//192.168.64.1:26657/broadcast_tx_commit?tx=_
//192.168.64.1:26657/broadcast_tx_sync?tx=_
//192.168.64.1:26657/check_tx?tx=_
//192.168.64.1:26657/commit?height=_
//192.168.64.1:26657/consensus_params?height=_
//192.168.64.1:26657/consensus_state?
//192.168.64.1:26657/dump_consensus_state?
//192.168.64.1:26657/genesis?
//192.168.64.1:26657/health?
//192.168.64.1:26657/net_info?
//192.168.64.1:26657/num_unconfirmed_txs?
//192.168.64.1:26657/status?
//192.168.64.1:26657/subscribe?query=_
//192.168.64.1:26657/tx?hash=_&prove=_
//192.168.64.1:26657/tx_search?query=_&prove=_&page=_&per_page=_&order_by=_
//192.168.64.1:26657/unconfirmed_txs?limit=_
//192.168.64.1:26657/unsubscribe?query=_
//192.168.64.1:26657/unsubscribe_all?
//192.168.64.1:26657/validators?height=_&page=_&per_page=_


All of the above seem to be `.GET` endpoints.

A  `tcpdump` trace seems to indicate that one can also send `.POST` requests .

`./nameservicecli query account cosmos1phqfg26hx5wkm5c9d7969kwk0th857u7a3s2h6 --node "tcp://192.168.64.1:26657"`

`sudo tcpdump -ttttnnvvSX  port 26657`
```
2021-02-11 22:27:18.220084 IP (tos 0x0, ttl 63, id 21885, offset 0, flags [DF], proto TCP (6), length 414)
    192.168.64.2.56482 > 192.168.64.1.26657: Flags [P.], cksum 0x034a (correct), seq 3247364002:3247364364, ack 2170633841, win 502, options [nop,nop,TS val 981732450 ecr 1217781408], length 362
    0x0000:  768f 3ccb f264 2644 2ad4 0515 0800 4500  v.<..d&D*.....E.
    0x0010:  019e 557d 4000 3f06 e388 c0a8 4002 c0a8  ..U}@.?.....@...
    0x0020:  4001 dca2 6821 c18e d7a2 8161 3e71 8018  @...h!.....a>q..
    0x0030:  01f6 034a 0000 0101 080a 3a84 0c62 4895  ...J......:..bH.
    0x0040:  dea0 504f 5354 202f 2048 5454 502f 312e  ..POST./.HTTP/1.
    0x0050:  310d 0a48 6f73 743a 2031 3932 2e31 3638  1..Host:.192.168
    0x0060:  2e36 342e 313a 3236 3635 370d 0a55 7365  .64.1:26657..Use
    0x0070:  722d 4167 656e 743a 2047 6f2d 6874 7470  r-Agent:.Go-http
    0x0080:  2d63 6c69 656e 742f 312e 310d 0a43 6f6e  -client/1.1..Con
    0x0090:  7465 6e74 2d4c 656e 6774 683a 2032 3339  tent-Length:.239
    0x00a0:  0d0a 436f 6e74 656e 742d 5479 7065 3a20  ..Content-Type:.
    0x00b0:  7465 7874 2f6a 736f 6e0d 0a0d 0a7b 226a  text/json....{"j
    0x00c0:  736f 6e72 7063 223a 2232 2e30 222c 2269  sonrpc":"2.0","i
    0x00d0:  6422 3a30 2c22 6d65 7468 6f64 223a 2261  d":0,"method":"a
    0x00e0:  6263 695f 7175 6572 7922 2c22 7061 7261  bci_query","para
    0x00f0:  6d73 223a 7b22 6461 7461 223a 2237 4232  ms":{"data":"7B2
    0x0100:  3234 3136 3436 3437 3236 3537 3337 3332  2416464726573732
    0x0110:  3233 4132 3236 3336 4637 3336 4436 4637  23A22636F736D6F7
    0x0120:  3333 3137 3036 3837 3136 3636 3733 3233  3317068716667323
    0x0130:  3636 3837 3833 3537 3736 4236 4433 3536  6687835776B6D356
    0x0140:  3333 3936 3433 3733 3933 3633 3936 4237  33964373936396B7
    0x0150:  3736 4233 3037 3436 3833 3833 3533 3737  76B3074683835377
    0x0160:  3533 3736 3133 3337 3333 3236 3833 3632  5376133733268362
    0x0170:  3237 4422 2c22 6865 6967 6874 223a 2230  27D","height":"0
    0x0180:  222c 2270 6174 6822 3a22 6375 7374 6f6d  ","path":"custom
    0x0190:  2f61 6363 2f61 6363 6f75 6e74 222c 2270  /acc/account","p
    0x01a0:  726f 7665 223a 7472 7565 7d7d            rove":true}}
```

request:
```
{
   "jsonrpc": "2.0",
   "id": 0,
   "method": "abci_query",
   "params": 
       {
          "data": "7B2241646472657373223A22636F736D6F733170687166673236687835776B6D35633964373936396B776B3074683835377537613373326836227D",
          "height": "0",
          "path": "custom/acc/account",
          "prove": true
        }
}
```

where `data` is the hex value of the payload encoded as json:

```
7B2241646472657373223A22636F736D6F733170687166673236687835776B6D35633964373936396B776B3074683835377537613373326836227D 
to ascii =
{"Address":"cosmos1phqfg26hx5wkm5c9d7969kwk0th857u7a3s2h6"}
```

This is the response:
```
192.168.64.1.26657 > 192.168.64.2.57006: Flags [P.], cksum 0x95b5 (correct), seq 2339460167:2339460899, ack 521674375, win 2053, options [nop,nop,TS val 3647660777 ecr 1019653195], length 732
0x0000:  2644 2ad4 0515 768f 3ccb f264 0800 4500  &D*...v.<..d..E.
0x0010:  0310 0000 0000 4006 7694 c0a8 4001 c0a8  ......@.v...@...
0x0020:  4002 6821 deae 8b71 5447 1f18 1e87 8018  @.h!...qTG......
0x0030:  0805 95b5 0000 0101 080a d96a e2e9 3cc6  ...........j..<.
0x0040:  ac4b 4854 5450 2f31 2e31 2032 3030 204f  .KHTTP/1.1.200.O
0x0050:  4b0d 0a43 6f6e 7465 6e74 2d54 7970 653a  K..Content-Type:
0x0060:  2061 7070 6c69 6361 7469 6f6e 2f6a 736f  .application/jso
0x0070:  6e0d 0a58 2d53 6572 7665 722d 5469 6d65  n..X-Server-Time
0x0080:  3a20 3136 3133 3134 3636 3237 0d0a 4461  :.1613146627..Da
0x0090:  7465 3a20 4672 692c 2031 3220 4665 6220  te:.Fri,.12.Feb.
0x00a0:  3230 3231 2031 363a 3137 3a30 3720 474d  2021.16:17:07.GM
0x00b0:  540d 0a43 6f6e 7465 6e74 2d4c 656e 6774  T..Content-Lengt
0x00c0:  683a 2035 3936 0d0a 0d0a 7b0a 2020 226a  h:.596....{..."j
0x00d0:  736f 6e72 7063 223a 2022 322e 3022 2c0a  sonrpc":."2.0",.
0x00e0:  2020 2269 6422 3a20 302c 0a20 2022 7265  .."id":.0,..."re
0x00f0:  7375 6c74 223a 207b 0a20 2020 2022 7265  sult":.{....."re
0x0100:  7370 6f6e 7365 223a 207b 0a20 2020 2020  sponse":.{......
0x0110:  2022 636f 6465 223a 2030 2c0a 2020 2020  ."code":.0,.....
0x0120:  2020 226c 6f67 223a 2022 222c 0a20 2020  .."log":."",....
0x0130:  2020 2022 696e 666f 223a 2022 222c 0a20  ..."info":."",..
0x0140:  2020 2020 2022 696e 6465 7822 3a20 2230  ....."index":."0
0x0150:  222c 0a20 2020 2020 2022 6b65 7922 3a20  ",......."key":.
0x0160:  6e75 6c6c 2c0a 2020 2020 2020 2276 616c  null,......."val
0x0170:  7565 223a 2022 6579 4a30 6558 426c 496a  ue":."eyJ0eXBlIj
0x0180:  6f69 5932 397a 6257 397a 4c58 4e6b 6131  oiY29zbW9zLXNka1
0x0190:  7776 5157 4e6a 6233 5675 6443 4973 496e  wvQWNjb3VudCIsIn
0x01a0:  5a68 6248 566c 496a 7037 496d 466a 5932  ZhbHVlIjp7ImFjY2
0x01b0:  3931 626e 524f 6457 3169 5a58 4969 4f69  91bnROdW1iZXIiOi
0x01c0:  4977 4969 7769 6348 5669 6247 6c6a 5332  IwIiwicHVibGljS2
0x01d0:  5635 496a 7037 6653 7769 6332 5678 6457  V5Ijp7fSwic2VxdW
0x01e0:  5675 5932 5569 4f69 4977 4969 7769 5932  VuY2UiOiIwIiwiY2
0x01f0:  3970 626e 4d69 4f6c 7437 496d 526c 626d  9pbnMiOlt7ImRlbm
0x0200:  3974 496a 6f69 626d 4674 5a58 5276 6132  9tIjoibmFtZXRva2
0x0210:  5675 4969 7769 5957 3176 6457 3530 496a  VuIiwiYW1vdW50Ij
0x0220:  6f69 4d54 4177 4d43 4a39 4c48 7369 5a47  oiMTAwMCJ9LHsiZG
0x0230:  5675 6232 3069 4f69 4a7a 6447 4672 5a53  Vub20iOiJzdGFrZS
0x0240:  4973 496d 4674 6233 5675 6443 4936 496a  IsImFtb3VudCI6Ij
0x0250:  4577 4d44 4177 4d44 4177 4d43 4a39 5853  EwMDAwMDAwMCJ9XS
0x0260:  7769 5957 526b 636d 567a 6379 4936 496d  wiYWRkcmVzcyI6Im
0x0270:  4e76 6332 3176 637a 4677 6148 466d 5a7a  Nvc21vczFwaHFmZz
0x0280:  4932 6148 6731 6432 7474 4e57 4d35 5a44  I2aHg1d2ttNWM5ZD
0x0290:  6335 4e6a 6c72 6432 7377 6447 6734 4e54  c5Njlrd2swdGg4NT
0x02a0:  6431 4e32 457a 637a 4a6f 4e69 4a39 6651  d1N2EzczJoNiJ9fQ
0x02b0:  3d3d 222c 0a20 2020 2020 2022 7072 6f6f  ==",......."proo
0x02c0:  664f 7073 223a 207b 0a20 2020 2020 2020  fOps":.{........
0x02d0:  2022 6f70 7322 3a20 5b5d 0a20 2020 2020  ."ops":.[]......
0x02e0:  207d 2c0a 2020 2020 2020 2268 6569 6768  .},......."heigh
0x02f0:  7422 3a20 2231 3036 3939 222c 0a20 2020  t":."10699",....
0x0300:  2020 2022 636f 6465 7370 6163 6522 3a20  ..."codespace":.
0x0310:  2222 0a20 2020 207d 0a20 207d 0a7d       "".....}...}.}

```

```
{
    "jsonrpc": "2.0",
    "id": 0,
    "result": {
        "response": {
            "code": 0,
            "log": "",
            "info": "",
            "index": "0",
            "key": null,
            "value": "eyJ0eXBlIjoiY29zbW9zLXNka1wvQWNjb3VudCIsInZhbHVlIjp7ImFjY291bnROdW1iZXIiOiIwIiwicHVibGljS2V5Ijp7fSwic2VxdWVuY2UiOiIwIiwiY29pbnMiOlt7ImRlbm9tIjoibmFtZXRva2VuIiwiYW1vdW50IjoiMTAwMCJ9LHsiZGVub20iOiJzdGFrZSIsImFtb3VudCI6IjEwMDAwMDAwMCJ9XSwiYWRkcmVzcyI6ImNvc21vczFwaHFmZzI2aHg1d2ttNWM5ZDc5Njlrd2swdGg4NTd1N2EzczJoNiJ9fQ==",
            "proofOps": {
                "ops": []
            },
            "height": "10699",
            "codespace": ""
        }
    }
}

```

`value` is json encoded in base64 <- should this be in hex?


```

eyJ0eXBlIjoiY29zbW9zLXNka1wvQWNjb3VudCIsInZhbHVlIjp7ImFjY291bnROdW1iZXIiOiIwIiwicHVibGljS2V5Ijp7fSwic2VxdWVuY2UiOiIwIiwiY29pbnMiOlt7ImRlbm9tIjoibmFtZXRva2VuIiwiYW1vdW50IjoiMTAwMCJ9LHsiZGVub20iOiJzdGFrZSIsImFtb3VudCI6IjEwMDAwMDAwMCJ9XSwiYWRkcmVzcyI6ImNvc21vczFwaHFmZzI2aHg1d2ttNWM5ZDc5Njlrd2swdGg4NTd1N2EzczJoNiJ9fQ==

{"type":"cosmos-sdk\/Account","value":{"accountNumber":"0","publicKey":{},"sequence":"0","coins":[{"denom":"nametoken","amount":"1000"},{"denom":"stake","amount":"100000000"}],"address":"cosmos1phqfg26hx5wkm5c9d7969kwk0th857u7a3s2h6"}}
```

error response:
```
{
  "jsonrpc": "2.0",
  "id": -1,
  "result": {
    "response": {
      "code": 1,
      "log": "The operation couldn’t be completed. (Cosmos.CosmosError error 1.)",
      "info": "",
      "index": "0",
      "key": null,
      "value": null,
      "proofOps": {
        "ops": []
      },
      "height": "0",
      "codespace": "undefined"
    }
  }

```






