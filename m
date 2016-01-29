Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37561 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932897AbcA2SYi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 29 Jan 2016 13:24:38 -0500
Subject: Re: [RFT PATCH v7 9/9] watchdog: dw_wdt: Convert to use watchdog
 infrastructure
To: Doug Anderson <dianders@chromium.org>,
	Guenter Roeck <patchwork@patchwork.roeck-us.net>
References: <1453776796-3885-1-git-send-email-patchwork@patchwork.roeck-us.net>
 <1453776796-3885-10-git-send-email-patchwork@patchwork.roeck-us.net>
 <CAD=FV=ULSrU+Hwiif=FAHE5EuNkTEtY85cnS-mUbO5eFb8JuHw@mail.gmail.com>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56ABAE61.2020607@roeck-us.net>
Date: Fri, 29 Jan 2016 10:24:33 -0800
MIME-Version: 1.0
In-Reply-To: <CAD=FV=ULSrU+Hwiif=FAHE5EuNkTEtY85cnS-mUbO5eFb8JuHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Doug,

On 01/29/2016 09:52 AM, Doug Anderson wrote:
> Guenter,
>
> On Mon, Jan 25, 2016 at 6:53 PM, Guenter Roeck
> <patchwork@patchwork.roeck-us.net> wrote:
>> From: Guenter Roeck <linux@roeck-us.net>
>>
>> Convert driver to use watchdog infrastructure. This includes
>> infrastructure support to handle watchdog keepalive if the watchdog
>> is running while the watchdog device is closed.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>
>> ---
>> v7: Set max_hw_timeout_ms
>>      Rebased to v4.5-rc1
>> v6: Added patch
>> ---
>>   drivers/watchdog/Kconfig  |   1 +
>>   drivers/watchdog/dw_wdt.c | 323 +++++++++++++++++-----------------------------
>>   2 files changed, 117 insertions(+), 207 deletions(-)
>
> I used the following test environment:
> * Rockchip rk3288-based Chromebook
> * v4.4-based kernel (specifically commit b1ba57898bfc
> ("veyron_defconfig: update for 4.5-rc") from Heiko Stuebner "somewhat
> stable" development tree
> * Pulled in some USB-related fixes (just for my own testing)
> * Pulled in Wim's most recent pull request for watchdog subsystem
> (ac36856fe432 watchdog: asm9260: remove __init and __exit annotations)
> * Applied all 9 of your patches
> * Test with daisydog
> <https://chromium.googlesource.com/chromiumos/third_party/daisydog/>
>
>
> I did these tests:
>
> ###
> # Confirm normal functionality
> ###
>
> stop daisydog
> daisydog -c
> # HW watchdog interval is 43 seconds
> # /dev/watchdog reported boot status: normal-boot
>
> cat /dev/watchdog
> # cat: [ 5401.044582] watchdog watchdog0: watchdog did not stop!
> # /dev/watchdog: Invalid argument
>
> for i in $(seq 60); do
>     echo $i
>     sleep 1
>   done
> # 1 - 43 printed, then reboot
>
> ###
> # Try setting interval, confirm all good (no reboots)
> # ...then confirm that reboot happens in 10 sec
> ###
>
> stop daisydog
> daisydog -c
> # HW watchdog interval is 43 seconds
> # /dev/watchdog reported boot status: normal-boot
>
> daisydog -i 10
> # HW watchdog interval is 10 seconds
> # /dev/watchdog reported boot status: normal-boot
>
> <Ctrl-C>
>
> daisydog -c
> # HW watchdog interval is 10 seconds
> # /dev/watchdog reported boot status: normal-boot
>
> sleep 60
> # No reboots
>
> cat /dev/watchdog
> # cat: [ 5401.044582] watchdog watchdog0: watchdog did not stop!
> # /dev/watchdog: Invalid argument
>
> for i in $(seq 60); do
>     echo $i
>     sleep 1
>   done
> # 1 - 11 printed, then reboot
>
> ###
> # Try setting interval super long
> # (outside of hardware range)
> ###
>
> stop daisydog
> daisydog -i 100 -c
> # HW watchdog interval is 86 seconds
> # /dev/watchdog reported boot status: normal-boot
>
> cat /dev/watchdog
> # cat: [ 5401.044582] watchdog watchdog0: watchdog did not stop!
> # /dev/watchdog: Invalid argument
>
> for i in $(seq 200); do
>     echo $i
>     sleep 1
>   done
> # 1 - 87 printed, then reboot; seems right to me.
>
> ###
> # Try with a interval that's in hardware range, but above default
> ###
>
> stop daisydog
> daisydog -i 70 -c
> # HW watchdog interval is 86 seconds
> # /dev/watchdog reported boot status: normal-boot
>
> cat /dev/watchdog
> # cat: [ 5401.044582] watchdog watchdog0: watchdog did not stop!
> # /dev/watchdog: Invalid argument
>
> for i in $(seq 200); do
>     echo $i
>     sleep 1
>   done
> # 1 - 87 printed, then reboot; seems right to me
>
> ###
> # Make sure my previous fix not regressed:
> # 04b1a62e6bb9 ("watchdog: dw_wdt: keepalive the watchdog at write time")
> ###
>
> stop daisydog
> while true; do daisydog -c > /dev/null; done
>
> # Let the above run for a 2 minutes and see no reboot.
>
> ###
> # See what happens when you change things midway
> ###
>
> stop daisydog
> daisydog -c
> # HW watchdog interval is 43 seconds
> # /dev/watchdog reported boot status: normal-boot
>
> cat /dev/watchdog
> # cat: [ 5401.044582] watchdog watchdog0: watchdog did not stop!
> # /dev/watchdog: Invalid argument
>
> for i in $(seq 30); do
>     echo $i
>     sleep 1
>   done
> # 1 - 30 printed
>
> daisydog -c -i 10
> # HW watchdog interval is 10 seconds
> # /dev/watchdog reported boot status: normal-boot
>
> sleep 60
> # No reboot; right since the "-c -i 10" patted + closed properly
>
> ===
>
> I also tried the new functionality enabled by your new patch and added
> "timeout-sec = <10>" to my device tree.  That seemed to work.  Upon
> bootup the watchdog defaulted to 10 seconds.  I also tried setting it
> to 86 in the device tree with similar success.
>
> ===
>
> The above seem to cover all the cases I can think of.
>
> Tested-by: Douglas Anderson <dianders@chromium.org>
>

Excellent - thanks a lot for the testing!

Guenter

