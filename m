Return-path: <dvhart@infradead.org>
Date: Tue, 7 Jun 2016 15:03:23 -0700
From: Darren Hart <dvhart@infradead.org>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, qipeng.zha@intel.com
Subject: Re: [PATCH 2/2] x86: Fix Apollo Lake Watchdog address in PMC driver
Message-ID: <20160607220323.GA28348@f23x64.localdomain>
References: <1463541972-19758-1-git-send-email-jonathan.yong@intel.com>
 <1463541972-19758-3-git-send-email-jonathan.yong@intel.com>
 <573BE985.1000306@roeck-us.net>
 <573BF421.2020503@intel.com>
 <573C7E0C.7050304@roeck-us.net>
 <20160524201316.GA5857@f23x64.localdomain>
 <57455A8B.1090807@intel.com>
 <574FEE13.30500@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <574FEE13.30500@intel.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Jun 02, 2016 at 04:28:03PM +0800, Yong, Jonathan wrote:
> On 05/25/2016 15:55, Yong, Jonathan wrote:
> > On 05/25/2016 04:13, Darren Hart wrote:
> > > 
> > > The history of this driver is for Apollo Lake, so the question is if
> > > there exist
> > > v3 and v5 APL products, or if we only need to concern ourselves with
> > > v5 in the
> > > upstream driver.
> > > 
> > > Especially given the "I don't know if this is the right way" in the cover
> > > letter, I will need an Acked-by at the very least from Qipeng.
> > > 
> > 
> > Hi Qipeng,
> > 
> > Do you know the history behind drivers/platform/x86/intel_pmc_ipc.c?
> > Were the specs based on earlier prototypes?
> > 
> 
> Qipeng, ping?
> 

Jonathan, can you follow-up with Qiping (possibly internally) and get back to
the list with a definitive response? Getting these into 4.7-rc would be good so
we don't have to push it back via stable, but we need to be sure it's the right
fix.

-- 
Darren Hart
Intel Open Source Technology Center
