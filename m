Return-path: <justinpopo6@gmail.com>
MIME-Version: 1.0
In-Reply-To: <56CB1FE5.8080206@roeck-us.net>
References: <20160222121132.665b1f77@endymion>
	<56CB1FE5.8080206@roeck-us.net>
Date: Mon, 22 Feb 2016 09:58:25 -0800
Message-ID: <CAJx26kWTo9OEZ-FCPMwE4t+=zZNf5d97sDRTx-FibEf92Tg--w@mail.gmail.com>
Subject: Re: [PATCH] watchdog: Add hardware dependency to BCM7038 driver
From: Justin Chen <justinpopo6@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.de>, linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hello Jean,

This driver is based off of a Broadcom watchdog block, it is not tied
to the MIPS core.
The watchdog driver is named BCM7038 because that was the first chip
that featured this watchdog block. Their are other chips that use this
driver that are not MIPS based.

Thanks,
Justin



On Mon, Feb 22, 2016 at 6:49 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 02/22/2016 03:11 AM, Jean Delvare wrote:
>>
>> The BCM7038 is a MIPS chip so do not present its driver on other
>> architectures, unless build-testing.
>>
>> Signed-off-by: Jean Delvare <jdelvare@suse.de>
>> Cc: Justin Chen <justinpopo6@gmail.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Wim Van Sebroeck <wim@iguana.be>
>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
