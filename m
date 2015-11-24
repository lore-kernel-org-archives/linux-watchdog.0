Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38499 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbbKXSTP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 13:19:15 -0500
Date: Tue, 24 Nov 2015 10:19:11 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Carlo Caione <carlo@caione.org>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Daniel Drake <drake@endlessm.com>,
	Jerry Cao <jerry.cao@amlogic.com>,
	Victor Wan <victor.wan@amlogic.com>,
	Romain Perier <romain.perier@gmail.com>,
	Carlo Caione <carlo@endlessm.com>
Subject: Re: [PATCH v3 1/4] watchdog: meson: Enable meson SoC specific data
Message-ID: <20151124181911.GA12289@roeck-us.net>
References: <1446985137-25498-1-git-send-email-carlo@caione.org>
 <1446985137-25498-2-git-send-email-carlo@caione.org>
 <5640B5BF.9040909@roeck-us.net>
 <CAOQ7t2bmNNTPxgZy4uZQF_u4yH2nxfMR_FqpKM0GavoUS9rRkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ7t2bmNNTPxgZy4uZQF_u4yH2nxfMR_FqpKM0GavoUS9rRkA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 11, 2015 at 09:54:04AM +0100, Carlo Caione wrote:
> On Mon, Nov 9, 2015 at 4:03 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On 11/08/2015 04:18 AM, Carlo Caione wrote:
> >>
> >> From: Carlo Caione <carlo@endlessm.com>
> >>
> >> With this patch we refactor the driver code to enable watchdog support
> >> for all platforms based on Amlogic meson SoCs.
> >> The new default timeout is also now chosen considering the maximum
> >> timeout allowed by the SoC.
> >>
> >> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> >
> >
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Wim,
> any (N)ACK on this?
> 
Carlo,

Unless I missed it, we still don't have an Ack from a devicetree
maintainer for the devicetree changes.

Guenter
