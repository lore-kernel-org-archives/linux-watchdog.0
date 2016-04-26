Return-path: <colin.king@canonical.com>
Subject: Re: [PATCH] watchdog: trivial fix of spelling mistake on "allocate"
To: Guenter Roeck <linux@roeck-us.net>, Joe Perches <joe@perches.com>
References: <1461611991-27328-1-git-send-email-colin.king@canonical.com>
 <1461648139.2726.119.camel@perches.com> <20160426165000.GA30901@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, Jiri Kosina <trivial@kernel.org>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <571FA30D.4040603@canonical.com>
Date: Tue, 26 Apr 2016 18:19:09 +0100
MIME-Version: 1.0
In-Reply-To: <20160426165000.GA30901@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 26/04/16 17:50, Guenter Roeck wrote:
> On Mon, Apr 25, 2016 at 10:22:19PM -0700, Joe Perches wrote:
>> On Mon, 2016-04-25 at 20:19 +0100, Colin King wrote:
>>> fix spelling mistake, alloacate -> allocate
>> []
>>> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
>> []
>>> @@ -161,7 +161,7 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>>>  	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct jz4740_wdt_drvdata),
>>>  			       GFP_KERNEL);
>>>  	if (!drvdata) {
>>> -		dev_err(&pdev->dev, "Unable to alloacate watchdog device\n");
>>> +		dev_err(&pdev->dev, "Unable to allocate watchdog device\n");
>>
>> Might as well delete this line instead.
>>
> Excellent point.
> 
> Colin, please resend and just drop the error message. It is not needed
> because an error message is already printed by devm_kzalloc().

Will do.

> 
> Thanks,
> Guenter
> 
