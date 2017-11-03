Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:47996 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756100AbdKCMNL (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Nov 2017 08:13:11 -0400
MIME-Version: 1.0
In-Reply-To: <0ed06c9aabd0f6d707f3ab8024282a764ffe0318.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com> <0ed06c9aabd0f6d707f3ab8024282a764ffe0318.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 3 Nov 2017 14:13:09 +0200
Message-ID: <CAHp75VffZCTgsbgm3RU-vAL4Xf1A60NtDaFwaLQRp5UqtztfuQ@mail.gmail.com>
Subject: Re: [RFC v8 1/7] platform/x86: intel_punit_ipc: Fix resource ioremap warning
To: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        "x86@kernel.org" <x86@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Ingo Molnar <mingo@redhat.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy@infradead.org>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Oct 29, 2017 at 11:49 AM,
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> For PUNIT device, ISPDRIVER_IPC and GTDDRIVER_IPC resources are not
> mandatory. So when PMC IPC driver creates a PUNIT device, if these
> resources are not available then it creates dummy resource entries for
> these missing resources. But during PUNIT device probe, doing ioremap on
> these dummy resources generates following warning messages.
>
> intel_punit_ipc: can't request region for resource [mem 0x00000000]
> intel_punit_ipc: can't request region for resource [mem 0x00000000]
> intel_punit_ipc: can't request region for resource [mem 0x00000000]
> intel_punit_ipc: can't request region for resource [mem 0x00000000]
>
> This patch fixes this issue by adding extra check for resource size
> before performing ioremap operation.

I think I already told that this one had been pushed to my review and
testing queue, thanks!

>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/intel_punit_ipc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> Changes since v7:
>  * None
>
> Changes since v6:
>  * None
>
> Changes since v5:
>  * None
>
> Changes since v4:
>  * None
>
> diff --git a/drivers/platform/x86/intel_punit_ipc.c b/drivers/platform/x86/intel_punit_ipc.c
> index a47a41f..b5b8901 100644
> --- a/drivers/platform/x86/intel_punit_ipc.c
> +++ b/drivers/platform/x86/intel_punit_ipc.c
> @@ -252,28 +252,28 @@ static int intel_punit_get_bars(struct platform_device *pdev)
>          * - GTDRIVER_IPC BASE_IFACE
>          */
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> -       if (res) {
> +       if (res && resource_size(res) > 1) {
>                 addr = devm_ioremap_resource(&pdev->dev, res);
>                 if (!IS_ERR(addr))
>                         punit_ipcdev->base[ISPDRIVER_IPC][BASE_DATA] = addr;
>         }
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
> -       if (res) {
> +       if (res && resource_size(res) > 1) {
>                 addr = devm_ioremap_resource(&pdev->dev, res);
>                 if (!IS_ERR(addr))
>                         punit_ipcdev->base[ISPDRIVER_IPC][BASE_IFACE] = addr;
>         }
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 4);
> -       if (res) {
> +       if (res && resource_size(res) > 1) {
>                 addr = devm_ioremap_resource(&pdev->dev, res);
>                 if (!IS_ERR(addr))
>                         punit_ipcdev->base[GTDRIVER_IPC][BASE_DATA] = addr;
>         }
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 5);
> -       if (res) {
> +       if (res && resource_size(res) > 1) {
>                 addr = devm_ioremap_resource(&pdev->dev, res);
>                 if (!IS_ERR(addr))
>                         punit_ipcdev->base[GTDRIVER_IPC][BASE_IFACE] = addr;
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
