Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:58562 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752589Ab3HUUBN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 21 Aug 2013 16:01:13 -0400
Date: Wed, 21 Aug 2013 22:01:05 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Kukjin Kim <kgene@kernel.org>
Cc: 'Leela Krishna Amudala' <l.krishna@samsung.com>,
	linux-samsung-soc@vger.kernel.org, dianders@chromium.org,
	jg1.han@samsung.com, t.figa@samsung.com, sachin.kamat@linaro.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V3] watchdog: s3c2410_wdt: remove the global variables
Message-ID: <20130821200105.GB815@spo001.leaseweb.com>
References: <1374569985-13576-1-git-send-email-l.krishna@samsung.com> <0e8301ce8842$eca72880$c5f57980$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e8301ce8842$eca72880$c5f57980$@org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi All,

> Leela Krishna Amudala wrote:
> > 
> > This patch removes the global variables in the driver file and
> > group them into a structure.
> > 
> > Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> 
> (+ Wim Van Sebroeck)
> 
> Looks good to me,
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> Thanks,
> Kukjin

Can someone sent me the (unquoted) patch so that I can review and add it?

Thanks in advance,
Wim.

