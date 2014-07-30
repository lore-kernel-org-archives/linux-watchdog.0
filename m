Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:54907 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbaG3BDi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Jul 2014 21:03:38 -0400
Message-id: <53D84468.6070001@samsung.com>
Date: Wed, 30 Jul 2014 10:03:36 +0900
From: Sangjung <sangjung.woo@samsung.com>
MIME-version: 1.0
To: Randy Dunlap <rdunlap@infradead.org>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	again4you@gmail.com, Jiri Kosina <trivial@kernel.org>
Subject: Re: [PATCH] Documentation: fix a typo in watchdog-api.txt
References: <1406621064-5466-1-git-send-email-sangjung.woo@samsung.com>
 <53D7D02D.6010508@infradead.org>
In-reply-to: <53D7D02D.6010508@infradead.org>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


On 07/30/2014 01:47 AM, Randy Dunlap wrote:
> On 07/29/14 01:04, Sangjung Woo wrote:
>> Signed-off-by: Sangjung Woo <sangjung.woo@samsung.com>
>> ---
>>   Documentation/watchdog/watchdog-api.txt |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/watchdog/watchdog-api.txt b/Documentation/watchdog/watchdog-api.txt
>> index eb7132e..53c49a4 100644
>> --- a/Documentation/watchdog/watchdog-api.txt
>> +++ b/Documentation/watchdog/watchdog-api.txt
>> @@ -118,7 +118,7 @@ resets.
>>   Note that the pretimeout is the number of seconds before the time
>>   when the timeout will go off.  It is not the number of seconds until
>>   the pretimeout.  So, for instance, if you set the timeout to 60 seconds
>> -and the pretimeout to 10 seconds, the pretimout will go of in 50
>> +and the pretimeout to 10 seconds, the pretimout will go off in 50
>                                           pretimeout
>
> Please correct that word also and then resend.  Also resend to:
> trivial@kernel.org
>
> Thanks.

I resent it after modification.
Thanks for your opinion.

Best regards,
Sangjung

>
>>   seconds.  Setting a pretimeout to zero disables it.
>>   
>>   There is also a get function for getting the pretimeout:
>>
>

