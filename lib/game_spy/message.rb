class GameSpy::Messsage
  GTI2_MAGIC_STRING = "\xFE\xFE"
  GTI2_MAGIC_STRING_LEN = 2

  # message types
  # reliable messages
  # all start with <magic-string> <type> <serial-number> <expected-serial-number>
  # type is 1 bytes, SN and ESN are 2 bytes each

  # Terminology for SN and ESN above may be wrong, possibly correct:
  # SN = Sequence Number
  # ESN = Extended Sequence Number

  GTI2MsgAppReliable = 0     # reliable application message
  GTI2MsgClientChallenge = 1 # client's challenge to the server (initial connection request)
  GTI2MsgServerChallenge = 2 # server's response to the client's challenge, and his challenge to the client
  GTI2MsgClientResponse = 3  # client's response to the server's challenge
  GTI2MsgAccept = 4          # server accepting client's connection attempt
  GTI2MsgReject = 5          # server rejecting client's connection attempt
  GTI2MsgClose = 6           # message indicating the connection is closing
  GTI2MsgKeepAlive = 7       # keep-alive used to help detect dropped connections

  GTI2NumReliableMessages = 8


  # unreliable messages
  # unreliable messages don't really have a message type, just the magic string repeated at the start

  GTI2MsgAck = 100            # acknowledge receipt of reliable message(s)
  GTI2MsgNack = 101           # alert sender to missing reliable message(s)
  GTI2MsgPing = 102           # used to determine latency
  GTI2MsgPong = 103           # a reply to a ping
  GTI2MsgClosed = 104         # confirmation of connection closure (GTI2MsgClose or GTI2MsgReject) - also sent in response to bad messages from unknown addresses
end
