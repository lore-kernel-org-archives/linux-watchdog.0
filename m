Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39543 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbcF1RRd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jun 2016 13:17:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Jun 2016 10:17:32 -0700
From: Thomas Pedersen <twp@codeaurora.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	Matthew McClintock <mmcclint@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/3] watchdog: qcom: update device tree bindings
In-Reply-To: <57720917.5000006@roeck-us.net>
References: <1467070010-16965-1-git-send-email-twp@codeaurora.org>
 <1467070010-16965-2-git-send-email-twp@codeaurora.org>
 <57720917.5000006@roeck-us.net>
Message-ID: <5841fb0decf9d57754d26aa5d3255eaf@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 2016-06-27 22:20, Guenter Roeck wrote:
> On 06/27/2016 04:26 PM, Thomas Pedersen wrote:
>> From: Matthew McClintock <mmcclint@codeaurora.org>
>> 
>> Update the compatible string to align with driver
>> 
>> CC: linux-watchdog@vger.kernel.org
>> Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
>> ---
>>   Documentation/devicetree/bindings/watchdog/qcom-wdt.txt | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt 
>> b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
>> index 4726924..60bb2f98 100644
>> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
>> @@ -4,9 +4,8 @@ Qualcomm Krait Processor Sub-system (KPSS) Watchdog
>>   Required properties :
>>   - compatible : shall contain only one of the following:
>> 
>> -			"qcom,kpss-wdt-msm8960"
>> -			"qcom,kpss-wdt-apq8064"
>> -			"qcom,kpss-wdt-ipq8064"
>> +			"qcom,kpss-timer"
>> +			"qcom,scss-timer"
>> 
>>   - reg : shall contain base register location and length
>>   - clocks : shall contain the input clock
>> 
> 
> Rob's earlier feedback to the same patch you had submitted in March:
> 
> "Keep the SoC specific ones even if they are not used. The DTS should
> have both strings."

Why would we add the SoC specific compatible strings to the DTS if 
they're not
even used?

-- 
thomas
