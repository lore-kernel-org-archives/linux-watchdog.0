Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36066 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbcGRPV7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Jul 2016 11:21:59 -0400
Received: by mail-oi0-f45.google.com with SMTP id w18so256942654oiw.3
        for <linux-watchdog@vger.kernel.org>; Mon, 18 Jul 2016 08:21:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160717195139.GC32751@spo001.leaseweb.nl>
References: <1464674890-10512-1-git-send-email-fu.wei@linaro.org> <20160717195139.GC32751@spo001.leaseweb.nl>
From: Fu Wei <fu.wei@linaro.org>
Date: Mon, 18 Jul 2016 23:21:58 +0800
Message-ID: <CADyBb7u=gU01RoVURmah7mRCLe1ZZZMgu92n5p5_fq9C9Uv_BQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] watchdog, sbsa_gwdt: Update SBSA watchdog with the
 new infrastructure of watchdog.
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>, panand@redhat.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	Timur Tabi <timur@codeaurora.org>, dyoung@redhat.com,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim, Guenter,

Great thanks for your help :-)

On 18 July 2016 at 03:51, Wim Van Sebroeck <wim@iguana.be> wrote:
> Hi Fu,
>
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This patchset:
>>     (1)Try to fix an issue about min and max timeout validity check:
>>     when max_hw_heartbeat_ms is defined, this check should be skipped.
>>
>>     (2)Use max_hw_heartbeat_ms instead of max_timeout in SBSA watchdog.
>>
>>     (3)Set WDOG_HW_RUNNING, when SBSA watchdog is already running before
>>     it's initialized.
>>
>> Changelog:
>> v1: The first formal upstreaming version
>>
>> RFC: https://lkml.org/lkml/2016/5/3/145
>>
>> Pratyush Anand (3):
>>   watchdog: skip min and max timeout validity check when
>>     max_hw_heartbeat_ms is defined
>>   sbsa_gwdt: Use max_hw_heartbeat_ms instead of max_timeout
>>   sbsa_gwdt: Set WDOG_HW_RUNNING, when watchdog is already running.
>>
>>  drivers/watchdog/sbsa_gwdt.c     | 6 ++++--
>>  drivers/watchdog/watchdog_core.c | 2 +-
>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> --
>> 2.5.5
>>
>
> These patches have been added to linux-watchdog-next.
>
> Kind regards,
> Wim.
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
