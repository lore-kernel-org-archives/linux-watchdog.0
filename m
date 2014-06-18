Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:35075 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724AbaFRTMt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Jun 2014 15:12:49 -0400
Date: Wed, 18 Jun 2014 22:04:48 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/3] MIPS: OCTEON: support disabling HOTPLUG_CPU run-time
Message-ID: <20140618190447.GA558@drone.musicnaut.iki.fi>
References: <1402949190-28182-1-git-send-email-aaro.koskinen@iki.fi>
 <1402949190-28182-2-git-send-email-aaro.koskinen@iki.fi>
 <53A0C40F.4020604@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53A0C40F.4020604@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On Tue, Jun 17, 2014 at 03:41:19PM -0700, David Daney wrote:
> There should be a separate variable to indicate if hot-plugging CPUs is
> possible which would be used here instead.
> 
> See my comments in patch 3/3 also.

OK, thanks for comments. I will revisit this after the Finnish
midsummer celebrations, i.e. it will take a couple of weeks.

A.
