Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33484 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbbJ0VUx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 27 Oct 2015 17:20:53 -0400
MIME-Version: 1.0
In-Reply-To: <1445978021-13961-3-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1445978021-13961-1-git-send-email-damien.riegel@savoirfairelinux.com>
	<1445978021-13961-3-git-send-email-damien.riegel@savoirfairelinux.com>
Date: Tue, 27 Oct 2015 16:20:52 -0500
Message-ID: <CADhT+wdWcYMQ_ZPhcGOye3oP=6N+Yos+sbqV20E5x5Hmfm8ycw@mail.gmail.com>
Subject: Re: [PATCH 2/4] watchdog: ts4800: add new driver for TS-4800 watchdog
From: Dinh Nguyen <dinh.linux@gmail.com>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	shawnguo@kernel.org, Sascha Hauer <kernel@pengutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Rob Herring <robh+dt@kernel.org>, kernel@savoirfairelinux.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 27, 2015 at 3:33 PM, Damien Riegel
<damien.riegel@savoirfairelinux.com> wrote:
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> ---
>  .../devicetree/bindings/watchdog/ts4800-wdt.txt    |  12 ++
>  drivers/watchdog/Kconfig                           |   9 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/ts4800_wdt.c                      | 212 +++++++++++++++++++++
>  4 files changed, 234 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
>  create mode 100644 drivers/watchdog/ts4800_wdt.c
>
> diff --git a/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt b/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
> new file mode 100644
> index 0000000..06bdb5f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
> @@ -0,0 +1,12 @@
> +Technologic Systems Watchdog
> +
> +Required properties:
> +- compatible : must be "ts,ts4800-wdt"
> +- reg : physical base address and length of memory mapped region
> +
> +Example:
> +
> +wdt1: wdt@b0010000 {
> +       compatible = "ts,ts4800-wdt";
> +       reg = <0xb0010000 0x1000>;
> +};
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 241fafd..cf30f3b 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -417,6 +417,15 @@ config NUC900_WATCHDOG
>           To compile this driver as a module, choose M here: the
>           module will be called nuc900_wdt.
>
> +config TS4800_WATCHDOG
> +       tristate "TS-4800 Watchdog"
> +       depends on SOC_IMX51

>From the DTS, I saw that this watchdog is on an FPGA, is it limited to only
the i.MX51?

Dinh
