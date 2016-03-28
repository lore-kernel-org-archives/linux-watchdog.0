Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59804 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbcC1SPo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Mar 2016 14:15:44 -0400
Date: Mon, 28 Mar 2016 11:15:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Matthew McClintock <mmcclint@codeaurora.org>
Cc: Rob Herring <robh@kernel.org>, andy.gross@linaro.org,
	linux-arm-msm@vger.kernel.org,
	qca-upstream.external@qca.qualcomm.com,
	linux-watchdog@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/17] watchdog: qcom: add kpss-standalone to device tree
 binding
Message-ID: <20160328181544.GB29820@roeck-us.net>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
 <1458770712-10880-10-git-send-email-mmcclint@codeaurora.org>
 <20160325141521.GA12357@rob-hp-laptop>
 <0F389D09-1165-4686-98DF-0265351A086A@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0F389D09-1165-4686-98DF-0265351A086A@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Mar 28, 2016 at 12:02:47PM -0500, Matthew McClintock wrote:
> On Mar 25, 2016, at 9:15 AM, Rob Herring <robh@kernel.org> wrote:
> > 
> > On Wed, Mar 23, 2016 at 05:05:04PM -0500, Matthew McClintock wrote:
> >> Update the compatible string to add new device tree binding
> >> 
> >> CC: linux-watchdog@vger.kernel.org
> >> Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
> >> ---
> >> Documentation/devicetree/bindings/watchdog/qcom-wdt.txt | 1 +
> >> 1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> >> index 60bb2f98..45b37cf 100644
> >> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> >> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> >> @@ -6,6 +6,7 @@ Required properties :
> >> 
> >> 			"qcom,kpss-timer"
> >> 			"qcom,scss-timer"
> >> +			"qcom,kpss-standalone"
> > 
> > What SoC(s) is this in. Use SoC specific compatible strings please.
> 
> So ipq4019 wins the race because we are the first to try to enable watchdog for this block?
> 
> qcom,kpss-ipq4019 ?
> 
It is a dedicated watchdog block, isn't it ? "qcom,kpss-ipq4019" would not
refer to a specific block. Devicetree maintainers may have a better idea,
but it seems to me that there should be 'wdt' or 'watchdog' in the property
name.

Guenter
