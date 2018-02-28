Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:38211 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933882AbeB1TqB (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Feb 2018 14:46:01 -0500
Date: Wed, 28 Feb 2018 12:45:58 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rwright@hpe.com, maurice.a.saldivar@hpe.com,
        Ingo Molnar <mingo@kernel.org>, marcus.folkesson@gmail.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH v5 2/9] watchdog/hpwdt: Remove legacy NMI sourcing.
Message-ID: <20180228194558.GB28906@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20180226032227.14615-1-jerry.hoemann@hpe.com>
 <20180226032227.14615-3-jerry.hoemann@hpe.com>
 <CAK8P3a1A5d52g-3Wgs1xP3P=dT6K0RVjmamfqAi9vE5TT=mo3g@mail.gmail.com>
 <03b13d44-9ce3-ead8-020d-4b1b8114079d@roeck-us.net>
 <20180227010250.GC8244@anatevka.americas.hpqcorp.net>
 <8766f2ee-428a-d72f-b0c3-e5fe68fd0a33@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8766f2ee-428a-d72f-b0c3-e5fe68fd0a33@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Feb 26, 2018 at 05:29:55PM -0800, Guenter Roeck wrote:
> On 02/26/2018 05:02 PM, Jerry Hoemann wrote:
> > On Mon, Feb 26, 2018 at 06:32:30AM -0800, Guenter Roeck wrote:
> > > On 02/26/2018 06:11 AM, Arnd Bergmann wrote:
> > > > On Mon, Feb 26, 2018 at 4:22 AM, Jerry Hoemann <jerry.hoemann@hpe.com> wrote:
> > > > > Gen8 and prior Proliant systems supported the "CRU" interface
> > > > > to firmware.  This interfaces allows linux to "call back" into firmware
> > > > > to source the cause of an NMI.  This feature isn't fully utilized
> > > > > as the actual source of the NMI isn't printed, the driver only
> > > > > indicates that the source couldn't be determined when the call
> > > > > fails.
> > > > > 
> > > > > With the advent of Gen9, iCRU replaces the CRU. The call back
> > > > > feature is no longer available in firmware.  To be compatible and
> > > > > not attempt to call back into firmware on system not supporting CRU,
> > > > > the SMBIOS table is consulted to determine if it is safe to
> > > > > make the call back or not.
> > > > > 
> > > > > This results in about half of the driver code being devoted
> > > > > to either making CRU calls or determing if it is safe to make
> > > > > CRU calls.  As noted, the driver isn't really using the results of
> > > > > the CRU calls.
> > > > > 
> > > > > Furthermore, as a consequence of the Spectre security issue, the
> > > > > BIOS/EFI calls are being wrapped into Spectre-disabling section.
> > > > > Removing the call back in hpwdt_pretimeout assists in this effort.
> > > > > 
> > > > > As the CRU sourcing of the NMI isn't required for handling the
> > > > > NMI and there are security concerns with making the call back, remove
> > > > > the legacy (pre Gen9) NMI sourcing and the DMI code to determine if
> > > > > the system had the CRU interface.
> > > > > 
> > > > > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> > > > 
> > > > This avoids a warning in mainline kernels, so that's great:
> > > > 
> > > > drivers/watchdog/hpwdt.o: warning: objtool: .text+0x24: indirect call
> > > > found in RETPOLINE build
> > > > 
> > > > I wonder what we do about stable kernels. Are both this patch and the patch
> > > > that added the objtool warning message candidates for backports to
> > > > stable kernels?
> > > > 
> > > 
> > > Makes sense to me, but it is really a bit more than a bug fix, so I'll
> > > leave it up to Jerry/HPE to make the call in respect to hpwdt.
> > > 
> > 
> > Generally speaking, HPE customers who run linux do so through a distro
> > vendor and pick up patches from them.  But I'm sure there are some
> > customers who do things differently.
> > 
> > The distro vendor's have their own repos and we'll work with them
> > to back port patches to their code base.  So, I typically don't do a lot
> > of kernel.org stable branch work.
> > 
> > Looks like objtool has been enhanced to find Spectre vulnerable code.
> > Are the other kernel patches related to Spectre being back ported
> > to stable release lines?  If yes, it probably make sense to do
> > the hpwdt change as well.
> > 
> 
> Spectre has been backported to v4.4 and later. I don't know about earlier kernels.
> 
> > Is just the patch removing the firmware call back wanted/needed? Or the
> > whole driver rewrite?  (The older baseline don't have all the watchdog
> > features that the patch set uses.)
> > 
> 
> We would only want to backport this patch. The rest is really out of scope.
> 
> > Which stable baseline(s) would need to be patched?  Priority?
> > 
> > Who does it?  (i.e. do you want me to submit patches to the stable baseline?)
> > 
> We would tag the patch for stable (and submit it into v4.16-rc). Greg would
> take care of the rest unless there are conflicts, in which case we get a note
> telling us that a backport is needed.
> 

Guenter,

Are you waiting for anything more from me on this patch, or are we
good for now until the back ports to v.15 etc.,?

Thanks

Jerry

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
