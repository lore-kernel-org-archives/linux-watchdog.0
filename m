Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:54812 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbaGHQXW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 8 Jul 2014 12:23:22 -0400
Date: Tue, 8 Jul 2014 09:23:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tomasz Figa <t.figa@samsung.com>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-samsung-soc@vger.kernel.org,
	Mike Turquette <mturquette@linaro.org>
Subject: Re: [RFC PATCH 2/3] clk: samsung: register restart notifiers for
 s3c2412 and s3c2443
Message-ID: <20140708162318.GB9157@roeck-us.net>
References: <1531376.ijR0PPyvmJ@diego>
 <1436436.XH2jFxzQOf@diego>
 <53BBFF22.10904@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53BBFF22.10904@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jul 08, 2014 at 04:24:34PM +0200, Tomasz Figa wrote:
> Hi Heiko,
> 
> On 06.07.2014 20:43, Heiko Stübner wrote:
> > S3C2412, S3C2443 and their derivatives contain a special software-reset
> > register in their system-controller.
> > 
> > Therefore register a restart-notifier for those.
> 
> I wonder if we really need to differentiate between these SoCs instead
> of just using the watchdog reset for all of them. If there is no reason
> to prefer software reset, then some code could be removed and things
> would be more unified.
> 
Depends if the other method is always available. If not, it might make sense
to register this handler with lower priority to have a fallback.

Guenter
