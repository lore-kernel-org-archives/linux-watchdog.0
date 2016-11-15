Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:60308 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751199AbcKORiU (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 15 Nov 2016 12:38:20 -0500
Date: Tue, 15 Nov 2016 09:38:16 -0800
From: Tony Lindgren <tony@atomide.com>
To: Cor Peters <cpeters@victronenergy.com>,
        Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: am33xx.dtsi: Added syscon compatible prcm_dev
 device
Message-ID: <20161115173816.GM4082@atomide.com>
References: <3071466.kDDk30H73u@corpeters>
 <20161115173515.GL4082@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161115173515.GL4082@atomide.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [161115 09:35]:
> * Cor Peters <cpeters@victronenergy.com> [161115 01:00]:
> > This patch adds the PRM_DEV as a syscon compatible device to
> > am33xx.dtsi. This is needed for the watchdog bootstatus patch.
> 
> We somehow need to see the bootreason for sure.. But we need to
> check with Tero on the reset driver work too.
> 
> Tero, does setting up of PRM_DEVICE as syscon cause issues for
> your reset driver work?

The nightmare scenario is that we have drivers calling random
syscon areas across various interconnect targets and then we have
zero chance of getting genpd to ever to work properly.

Do the reset drivers offer some way of exporting the reset status?

Regards,

Tony
