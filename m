Message-ID: <526F7569.7040903@openwrt.org>
Date: Tue, 29 Oct 2013 09:44:25 +0100
From: John Crispin <blogic@openwrt.org>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] watchdog: MIPS: add ralink watchdog driver
References: <1375954303-28830-1-git-send-email-blogic@openwrt.org> <20131029073935.GD19569@spo001.leaseweb.com>
In-Reply-To: <20131029073935.GD19569@spo001.leaseweb.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

On 29/10/13 08:39, Wim Van Sebroeck wrote:
> Hi John,
>
>> Add a driver for the watchdog timer found on Ralink SoC
>>
>> Signed-off-by: John Crispin<blogic@openwrt.org>
>> Cc: linux-watchdog@vger.kernel.org
>> Cc: linux-mips@linux-mips.org
>> ---
>>   drivers/watchdog/Kconfig      |    7 ++
>>   drivers/watchdog/Makefile     |    1 +
>>   drivers/watchdog/rt2880_wdt.c |  208 +++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 216 insertions(+)
>>   create mode 100644 drivers/watchdog/rt2880_wdt.c
> This patch (together with the DT binding part) has been added as 1 patch to linux-watchdog-next.
>
> Kind regards,
> Wim.
>
>
>

Hi Wim,

Thanks a lot for the review/merge

     John
