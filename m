Return-path: <jtheou@adeneo-embedded.us>
Date: Mon, 8 Jun 2015 15:02:49 -0700
From: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] watchdog_core: Add watchdog registration
 deferral mechanism
Message-ID: <20150608150249.3c6cfcfbe580f61f150359c1@adeneo-embedded.us>
In-Reply-To: <5575EE6F.3030001@roeck-us.net>
References: <1433629537-21925-1-git-send-email-jtheou@adeneo-embedded.us>
	<5575EE6F.3030001@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Indeed, it make sense.
I will fix this on v5.

Thanks a lot for your valuable feedbacks on this patch.

JB

On Mon, 8 Jun 2015 12:35:11 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 06/06/2015 03:25 PM, Jean-Baptiste Theou wrote:
> > Currently, watchdog subsystem require the misc subsystem to
> > register a watchdog. This may not be the case in case of an
> > early registration of a watchdog, which can be required when
> > the watchdog cannot be disabled.
> >
> > This patch introduces a deferral mechanism to remove this requirement.
> >
> > Signed-off-by: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
> > ---
> > Changes in v4:
> >   - Adjust patch based on Guenter feedbacks on v3
> >
> 
> You still have lines with > 80 columns, primarily because of very long
> variable names. I would suggest to pick shorter names - there is no
> technical reason for variables named watchdog_deferred_registration_XXX,
> and I don't see why we should have checkpatch warnings just because
> of long variable names.
> 
> Also, multi-line alignment is still not correct.
> I would suggest to run the patch through checkpatch --strict.
> 
> Thanks,
> Guenter
> 


-- 
Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
