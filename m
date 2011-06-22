Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:16708 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754242Ab1FVJ3e (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jun 2011 05:29:34 -0400
Date: Wed, 22 Jun 2011 11:05:20 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Thomas Abraham <thomas.abraham@linaro.org>,
	Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree-discuss@lists.ozlabs.org, kgene.kim@samsung.com,
	linaro-dev@lists.linaro.org, patches@linaro.org,
	linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 3/6] watchdog: s3c2410: Add support for device tree
	based probe
Message-ID: <20110622090520.GT23305@infomag.iguana.be>
References: <1308567752-13451-1-git-send-email-thomas.abraham@linaro.org> <1308567752-13451-4-git-send-email-thomas.abraham@linaro.org> <BANLkTikkxpOC6M1R0g=dGvDXvCkG6EOJhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BANLkTikkxpOC6M1R0g=dGvDXvCkG6EOJhQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Thomas, Grant,

> On Mon, Jun 20, 2011 at 5:02 AM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
> > This patch adds the of_match_table to enable s3c2410-wdt driver
> > to be probed when watchdog device node is found in the device tree.
> >
> > Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> You need to send this to Wim and the linux-watchdog mailing lists.  As
> far as I'm concerned, it can be merged immediately.

Yep, it looks OK. Please sent the patch so that it can be included.

Kind regards,
Wim.

