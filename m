Subject: Re: [PATCH V2 1/2] DT: Add documentation for ralink-wdt
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@codeaurora.org>
In-Reply-To: <1375954919-30737-1-git-send-email-blogic@openwrt.org>
Date: Thu, 8 Aug 2013 10:55:15 -0500
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <0631E84C-AC6E-4B75-9073-D6A2BFD9EB02@codeaurora.org>
References: <1375954919-30737-1-git-send-email-blogic@openwrt.org>
To: John Crispin <blogic@openwrt.org>
Return-Path: <galak@codeaurora.org>
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


On Aug 8, 2013, at 4:41 AM, John Crispin wrote:

> Describe ralink-wdt binding.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> ---
> V1 used the old devicetree list as Cc.
> 
> .../devicetree/bindings/watchdog/ralink-wdt.txt     |   19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/watchdog/ralink-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/ralink-wdt.txt b/Documentation/devicetree/bindings/watchdog/ralink-wdt.txt
> new file mode 100644
> index 0000000..a70f0e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/ralink-wdt.txt

Seems like this should be ralink-rt2880-wdt.txt (I'm guessing there are other ralink watchdog timers).

> @@ -0,0 +1,19 @@
> +Ralink Watchdog Timers

Should probably be Ralink RT2880 Watchdog Timer

> +
> +Required properties :
> +- compatible: must be "ralink,rt2880-wdt"
> +- reg: physical base address of the controller and length of the register range
> +
> +Optional properties :
> +- interrupt-parent: phandle to the INTC device node
> +- interrupts : Specify the INTC interrupt number

Since you'll be updating this to drop 'ralink,mt7620a-wdt' how about cleaning up the whitespace around ' :'

> +
> +Example:
> +
> +	watchdog@120 {
> +		compatible = "ralink,mt7620a-wdt", "ralink,rt2880-wdt";
> +		reg = <0x120 0x10>;
> +
> +		interrupt-parent = <&intc>;
> +		interrupts = <1>;
> +	};
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


- k

--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
