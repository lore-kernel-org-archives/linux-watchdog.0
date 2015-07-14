Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34885 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbbGNOt6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 14 Jul 2015 10:49:58 -0400
MIME-Version: 1.0
In-Reply-To: <1435068994-13526-2-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org> <1435068994-13526-1-git-send-email-fu.wei@linaro.org>
 <1435068994-13526-2-git-send-email-fu.wei@linaro.org>
From: Rob Herring <robherring2@gmail.com>
Date: Tue, 14 Jul 2015 09:49:38 -0500
Message-ID: <CAL_JsqJA4FNs4QSjep-sX-Oe=bGX087ZHcHOpASas5dKq0jZVQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] Documentation: add sbsa-gwdt.txt documentation
To: fu.wei@linaro.org
Cc: Suravee Suthikulanit <Suravee.Suthikulpanit@amd.com>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	tekkamanninja@gmail.com, G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>, vgandhi@codeaurora.org,
	Wim Van Sebroeck <wim@iguana.be>,
	"jcm@redhat.com" <jcm@redhat.com>, leo.duran@amd.com,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Rafael Wysocki <rjw@rjwysocki.net>, dyoung@redhat.com,
	panand@redhat.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jun 23, 2015 at 9:16 AM,  <fu.wei@linaro.org> wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> The sbsa-gwdt.txt documentation in devicetree/bindings/watchdog is for
> introducing SBSA(Server Base System Architecture) Generic Watchdog
> device node info into FDT.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  .../devicetree/bindings/watchdog/sbsa-gwdt.txt     | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt b/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
> new file mode 100644
> index 0000000..010e5c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
> @@ -0,0 +1,36 @@
> +* SBSA(Server Base System Architecture) Generic Watchdog
> +
> +The SBSA Generic Watchdog Timer is used for resetting the system after
> +two stages of timeout.
> +More details: ARM-DEN-0029 - Server Base System Architecture (SBSA)
> +
> +Required properties:
> +- compatible : Should at least contain "arm,sbsa-gwdt".
> +
> +- reg : base physical address of the frames and length of memory mapped region.

This needs to specify the ordering of refresh and control.

> +
> +- reg-names : Should contain the resource reg names to show the order of
> +  the values in "reg".
> +  Must include the following entries : "refresh", "control".

This should be optional.

> +- interrupts : Should at least contain WS0 interrupt,
> +  the WS1 Signal is optional.

s/Signal/interrupt/ ?

> +
> +- interrupt-names : Should contain the resource interrupt names.
> +  Must include the following entries : "ws0". "ws1" is optional.

This should be optional.

> +
> +Optional properties
> +- timeout-sec : Watchdog pre-timeout and timeout values (in seconds).
> +       The first is timeout values, then pre-timeout.
> +
> +Example for FVP Foundation Model v8:
> +
> +watchdog@2a440000 {
> +       compatible = "arm,sbsa-gwdt";
> +       reg = <0x0 0x2a440000 0 0x1000>,
> +             <0x0 0x2a450000 0 0x1000>;
> +       reg-names = "control", "refresh";
> +       interrupts = <0 27 4>;
> +       interrupt-names = "ws0";
> +       timeout-sec = <10 5>;
> +};
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
