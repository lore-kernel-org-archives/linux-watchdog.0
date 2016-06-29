Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48409 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbcF2CBY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jun 2016 22:01:24 -0400
Subject: Re: [PATCH v2 2/3] watchdog: qcom: add option for standalone watchdog
 not in timer block
To: Matthew McClintock <mmcclint@codeaurora.org>, twp@codeaurora.org
References: <1467138921-3658-1-git-send-email-twp@codeaurora.org>
 <1467138921-3658-2-git-send-email-twp@codeaurora.org>
 <20160628194723.GA1999@roeck-us.net>
 <f101c5e001fa521edf67f1a94917f15e@codeaurora.org>
 <75720F79-5C72-4FFD-A391-427C5D336AE0@codeaurora.org>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57732BF1.3060801@roeck-us.net>
Date: Tue, 28 Jun 2016 19:01:21 -0700
MIME-Version: 1.0
In-Reply-To: <75720F79-5C72-4FFD-A391-427C5D336AE0@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/28/2016 02:24 PM, Matthew McClintock wrote:
>
>> On Jun 28, 2016, at 3:45 PM, Thomas Pedersen <twp@codeaurora.org> wrote:
>>
>> I'll rectify the missing documentation, and am fine with changing the name to
>> kpss-core.
>
> I think the previous conclusion was to rename it to something with ipq4019 in the compat, but I’d suggest checking the comments in patchworks on the previous patches.
>

I looked up my notes. Here is what I had suggested earlier:

"The property name should probably be something like 'qcom,kpss-wdt'
(or 'qcom,kpss-watchdog' ?), possibly in addition to 'qcom,kpss-ipq4019-wdt'
and 'qcom,kpss-msm8916-wdt'."

Guenter

