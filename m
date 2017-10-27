Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:55556 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbdJ0QT1 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 27 Oct 2017 12:19:27 -0400
MIME-Version: 1.0
In-Reply-To: <de1b81a25959bcda0a73aa58ecc91df8207f7787.1508368279.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1508368279.git.sathyanarayanan.kuppuswamy@linux.intel.com> <de1b81a25959bcda0a73aa58ecc91df8207f7787.1508368279.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 27 Oct 2017 19:19:25 +0300
Message-ID: <CAHp75VeNFQLS_MM6weOW7dD7E0kRq9mUOOpnx-MLy88i7cBG1Q@mail.gmail.com>
Subject: Re: [RFC v6 3/9] platform/x86: intel_punit_ipc: Fix resource ioremap warning
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
        Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Oct 19, 2017 at 3:23 AM,
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> For PUNIT device, ISPDRIVER_IPC and GTDDRIVER_IPC resources are
> not mandatory. So when PMC IPC driver creates a PUNIT device, if
> these resources are not available then it creates dummy resource
> entries for these missing resources. But during PUNIT device probe
> , doing ioremap on these dummy resources generates following warning
> messages.

Applied for my review and testing queue, thanks!

>
> intel_punit_ipc intel_punit_ipc: can't request region for resource [mem
> 0x00000000]
> intel_punit_ipc intel_punit_ipc: can't request region for resource [mem
> 0x00000000]
> intel_punit_ipc intel_punit_ipc: can't request region for resource [mem
> 0x00000000]
> intel_punit_ipc intel_punit_ipc: can't request region for resource [mem
> 0x00000000]
>
> This patch fixes this issue by adding extra check for resource size
> before performing ioremap operation.
>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/platform/x86/intel_punit_ipc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
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
