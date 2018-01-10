Return-Path: <zboszor@pr.hu>
Return-path: <zboszor@pr.hu>
Subject: Re: [PATCH 12/12] watchdog: sp5100_tco: Add support for recent FCH
 versions
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>
References: <1514149457-20273-1-git-send-email-linux@roeck-us.net>
 <1514149457-20273-13-git-send-email-linux@roeck-us.net>
 <9bac4f60-e385-fef8-0a8f-7a473b079055@pr.hu>
 <20180104192114.GA28864@roeck-us.net>
From: Boszormenyi Zoltan <zboszor@pr.hu>
Message-ID: <d5184137-e909-9fc5-aa12-a551924c4241@pr.hu>
Date: Wed, 10 Jan 2018 09:34:08 +0100
MIME-Version: 1.0
In-Reply-To: <20180104192114.GA28864@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

I'm trying to remove non-ASCII chars from the mail body in the hope
it reaches the lists... My ISP still adds that X-Spam-Report: header
quoting large part of the mail body without MIME-encoding it.

On 2018-01-04 20:21, Guenter Roeck wrote:
> On Thu, Jan 04, 2018 at 01:01:22PM +0100, Boszormenyi Zoltan wrote:
>> On 2017-12-24 22:04, Guenter Roeck wrote:
>>> Starting with Family 16h Models 30h-3Fh and Family 15h Models 60h-6Fh,
>>> watchdog address space decoding has changed. The cutover point is already
>>> identified in the i2c-piix2 driver, so use the same mechanism.
>>
>> "i2c-piix4".
>>
> Thanks!
> 
>> Otherwise, I only have an older AMD FX CPU, so I can only test
>> whether it is not broken there.
>>
> 
> That is actually the important test. I tested myself on Ryzen 1700X.

I was able to test on a Kabini APU at work, my AMD FX at home still
needs to be tested. The driver loads properly:

[    5.620836] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    5.621002] sp5100-tco sp5100-tco: Using 0xfed80b00 for watchdog MMIO address
[    5.621611] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=1)

echo "1" >/dev/watchdog rebooted the machine after one minute properly.

You can add my Tested-by: line.

Best regards,
Zoltan Boszormenyi
