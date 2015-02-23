Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47155 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbbBWWHd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Feb 2015 17:07:33 -0500
Message-ID: <54EBA4A2.1050607@codeaurora.org>
Date: Mon, 23 Feb 2015 14:07:30 -0800
From: Stephen Boyd <sboyd@codeaurora.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>,
	Mathieu Olivari <mathieu@codeaurora.org>
CC: mark.rutland@arm.com, devicetree@vger.kernel.org,
	linux@arm.linux.org.uk, linux-watchdog@vger.kernel.org,
	pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, corbet@lwn.net,
	linux-kernel@vger.kernel.org, standby24x7@gmail.com, wim@iguana.be,
	robh+dt@kernel.org, galak@codeaurora.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] arm: msm: Use timer DT node for qcom watchdog config
References: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org> <5879121.Ud0l5ICsCF@wuerfel>
In-Reply-To: <5879121.Ud0l5ICsCF@wuerfel>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/23/15 13:35, Arnd Bergmann wrote:
> On Friday 20 February 2015 18:19:33 Mathieu Olivari wrote:
>> This change is done as a follow-up to the following thread:
>> https://lkml.org/lkml/2014/10/1/436
>>
>> qcom-wdt is currently assuming the presence of a dedicated node in DT
>> to gets its configuration. However, on msm architecture, the watchdog is
>> usually part of the timer block. So this patch-set is changing the driver
>> and slightly enhancing the timer DT bindings to provide the relevant clocks
>> and interrupts.
>>
>> Mathieu Olivari (3):
>>   watchdog: qcom: use timer devicetree binding
>>   ARM: qcom: add description of KPSS WDT for IPQ8064
>>   ARM: msm: add watchdog entries to DT timer binding doc
>>
>>  Documentation/devicetree/bindings/arm/msm/timer.txt | 16 +++++++++++++---
>>  arch/arm/boot/dts/qcom-ipq8064.dtsi                 | 14 +++++++++++++-
>>  drivers/watchdog/qcom-wdt.c                         | 21 +++++++++++++++------
>>  3 files changed, 41 insertions(+), 10 deletions(-)
>>
>>
> What about the binding document in
> Documentation/devicetree/bindings/watchdog/qcom-wdt.txt?
>
>

We can rewrite it for platforms starting with msm8974 and beyond or
delete it and write a new binding. It's a similar hardware block split
out from the timers and then made to use a SPI instead of a PPI for the
interrupt sources. We also lost the CPU remapping feature so there is
really only one watchdog instead of 2 per cpu. Oh and the register
offsets are different, but otherwise the registers are the same.

---8<-----

From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] Documentation: qcom-wdt: Update binding for individual block

On msm8974 and beyond the KPSS watchdog is split out of the timer
block and made to be a single instance instead of per-cpu. Let's
update the binding to reflect this and replace the binding that
is handled by the qcom,kpss-timer binding.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.txt | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
index 4726924d034e..78b92bec4c3a 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
@@ -2,14 +2,10 @@ Qualcomm Krait Processor Sub-system (KPSS) Watchdog
 ---------------------------------------------------
 
 Required properties :
-- compatible : shall contain only one of the following:
-
-			"qcom,kpss-wdt-msm8960"
-			"qcom,kpss-wdt-apq8064"
-			"qcom,kpss-wdt-ipq8064"
-
+- compatible : shall contain "qcom,kpss-wdt"
 - reg : shall contain base register location and length
 - clocks : shall contain the input clock
+- interrupts : shall contain the bark and bite interrupts in that order
 
 Optional properties :
 - timeout-sec : shall contain the default watchdog timeout in seconds,
@@ -17,8 +13,9 @@ Optional properties :
 
 Example:
 	watchdog@208a038 {
-		compatible = "qcom,kpss-wdt-ipq8064";
-		reg = <0x0208a038 0x40>;
+		compatible = "qcom,kpss-wdt";
+		reg = <0xf9017000 0x1000>;
+		interrupts = <0 3 0>, <0 4 0>;
 		clocks = <&sleep_clk>;
 		timeout-sec = <10>;
 	};

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

