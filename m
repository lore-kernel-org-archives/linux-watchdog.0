Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ashish Jangam <Ashish.Jangam@kpitcummins.com>
To: Wim Van Sebroeck <wim@iguana.be>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Anthony Olech <Anthony.Olech@diasemi.com>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>
Subject: RE: [PATCH] Watchdog: Fix for settimeout issue
Date: Thu, 24 May 2012 10:19:04 +0000
Message-ID: <C3AE124F08223B42BC95AEB82F0F6CED30402926@KCHJEXMB02.kpit.com>
References: <1335768031.9546.20.camel@dhruva>
 <20120523183623.GN3074@spo001.leaseweb.com>
In-Reply-To: <20120523183623.GN3074@spo001.leaseweb.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

> -----Original Message-----
> From: wimvs@spo001.leaseweb.com [mailto:wimvs@spo001.leaseweb.com] On
> Behalf Of Wim Van Sebroeck
> Sent: Thursday, May 24, 2012 12:06 AM
> To: Ashish Jangam
> Cc: linux-kernel@vger.kernel.org; linux-watchdog@vger.kernel.org; Anthony
> Olech; sameo@linux.intel.com
> Subject: Re: [PATCH] Watchdog: Fix for settimeout issue
> 
> Hi Ashish,
> 
> > Some devices have a fixed minimum elapse time and a ping before this
> > elapse time causes error condition. This patch fix this issue in the
> > settimeout operation.
> 
> Won't add this patch. The driver needs to take care of the mdelay.
> PS: for da9052_wdt: start (=set_timeout) + ping will also give you
> the same problem.

Ok, re-sending the patch with this fix....Ashish
> 
> Kind regards,
> Wim.
> 
