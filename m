Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57373 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964831AbbJ0QXJ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 27 Oct 2015 12:23:09 -0400
Date: Tue, 27 Oct 2015 16:22:57 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: fu.wei@linaro.org
Cc: linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, tekkamanninja@gmail.com, arnd@arndb.de,
	linux@roeck-us.net, vgandhi@codeaurora.org, wim@iguana.be,
	jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net,
	catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
	dyoung@redhat.com, panand@redhat.com,
	Suravee.Suthikulpanit@amd.com, robherring2@gmail.com
Subject: Re: [PATCH v8 1/5] Documentation: add sbsa-gwdt driver documentation
Message-ID: <20151027162257.GJ3091@leverpostej>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
 <1445961999-9506-2-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1445961999-9506-2-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 28, 2015 at 12:06:35AM +0800, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> The sbsa-gwdt.txt documentation in devicetree/bindings/watchdog is for
> introducing SBSA(Server Base System Architecture) Generic Watchdog
> device node info into FDT.
> 
> Also add sbsa-gwdt introduction in watchdog-parameters.txt
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  .../devicetree/bindings/watchdog/sbsa-gwdt.txt     | 46 ++++++++++++++++++++++
>  Documentation/watchdog/watchdog-parameters.txt     |  6 +++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt b/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
> new file mode 100644
> index 0000000..ad8e99a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
> @@ -0,0 +1,46 @@
> +* SBSA (Server Base System Architecture) Generic Watchdog
> +
> +The SBSA Generic Watchdog Timer is used to force a reset of the system
> +after two stages of timeout have elapsed.  A detailed definition of the
> +watchdog timer can be found in the ARM document: ARM-DEN-0029 - Server
> +Base System Architecture (SBSA)
> +
> +Required properties:
> +- compatible: Should at least contain "arm,sbsa-gwdt".
> +
> +- reg: Each entry specifies the base physical 64-bit address of a register
> +  frame and the 64-bit length of that frame; currently, two frames must be

Remove "64-bit" here. This depends on #address-cells and #size-cells, as
usual.

> +  defined, in this order:
> +  1: Watchdog control frame
> +  2: Refresh frame.
> +
> +- interrupts: At least one interrupt must be defined that will be used as
> +  the WS0 interrupt.  A WS1 interrupt definition can be provided, but is
> +  optional.  The interrupts must be defined in this order:
> +  1: WS0 interrupt
> +  2: WS1 interrupt

Why is WS1 optional?

> +Optional properties
> +- timeout-sec: To use a timeout value that is different from the driver
> +  default values, use this property. 

Either define a default value, or don't state anything about the
behaviour when this is not present.

>    If used, at least one timeout value
> +  (in seconds) must be provided.  A second optional timeout value (in
> +  seconds) may also be provided and will be used as the pre-timeout value,
> +  if it is given.
> +
> +  There are two possible sources for driver default timeout values:
> +  (1) the driver contains hard-coded default values, or
> +  (2) module parameters can be given when the module is loaded
> +
> +  If timeout/pretimeout values are provided when the module loads, they
> +  will take priority.  Second priority will be the timeout-sec from DTB,
> +  and third the hard-coded driver values.

The last two paragraphs should go. They describe Linux behaviour rather
than the binding.

Thanks,
Mark.
