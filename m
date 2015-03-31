Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:34419 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbbCaTeM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 31 Mar 2015 15:34:12 -0400
Received: by qcay5 with SMTP id y5so22918225qca.1
        for <linux-watchdog@vger.kernel.org>; Tue, 31 Mar 2015 12:34:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <551AEF56.4070504@roeck-us.net>
References: <1427827751-19705-1-git-send-email-abrestic@chromium.org>
	<1427827751-19705-2-git-send-email-abrestic@chromium.org>
	<551AEF56.4070504@roeck-us.net>
Date: Tue, 31 Mar 2015 12:34:11 -0700
Message-ID: <CAL1qeaF7vWGVvKpAmo7S5+5W9R6yF8U-JzBYw8Mv5H2UuOx5hw@mail.gmail.com>
Subject: Re: [PATCH 2/4] watchdog: imgpdc: Intialize timeout to default value
From: Andrew Bresticker <abrestic@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Naidu Tellapati <naidu.tellapati@imgtec.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Mar 31, 2015 at 12:02 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 03/31/2015 11:49 AM, Andrew Bresticker wrote:
>>
>> From: Naidu Tellapati <naidu.tellapati@imgtec.com>
>>
>> Currently the watchdog timeout is initialized to 0.  Initialize it to
>> its default value instead.
>>
>> Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>> ---
>>   drivers/watchdog/imgpdc_wdt.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
>> index c4151cd..f3f65ac 100644
>> --- a/drivers/watchdog/imgpdc_wdt.c
>> +++ b/drivers/watchdog/imgpdc_wdt.c
>> @@ -42,7 +42,7 @@
>>   #define PDC_WDT_MIN_TIMEOUT           1
>>   #define PDC_WDT_DEF_TIMEOUT           64
>>
>> -static int heartbeat;
>> +static int heartbeat = PDC_WDT_DEF_TIMEOUT;
>>   module_param(heartbeat, int, 0);
>>   MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds. "
>>         "(default = " __MODULE_STRING(PDC_WDT_DEF_TIMEOUT) ")");
>>
>
> The idea with watchdog_init_timeout() is that it can take the
> timeout from devicetree unless the module parameter is provided.
> By pre-initializing the module parameter, you defeat that and
> make watchdog_init_timeout more or less a no-op. You might as well
> set pdc_wdt->wdt_dev.timeout directly and not call watchdog_init_timeout
> at all if that is what you want.
>
> The "expected" solution would be to pre-initialize pdc_wdt->wdt_dev.timeout
> but leave the module parameter alone.

Ah, right - that would be better.  It looks like a patch that is
almost identical to mine has already been accepted - see linux-next
commit c774d71 ["watchdog: imgpdc: Fix default heartbeat"] - but I can
follow up with a patch that uses the approach you suggested.

Thanks,
Andrew
