Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41643 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965057AbeBMRov (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 13 Feb 2018 12:44:51 -0500
Date: Tue, 13 Feb 2018 09:44:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, rwright@hpe.com,
        maurice.a.saldivar@hpe.com
Subject: Re: [PATCH v2 04/11] watchdog/hpwdt: white space changes
Message-ID: <20180213174449.GB22401@roeck-us.net>
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
 <20180212052111.12010-5-jerry.hoemann@hpe.com>
 <CAOFm3uH0PUXVOxJmqDf-ZCm8vTp_6ERwYSC6Bt2-8r-C2yH9gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOFm3uH0PUXVOxJmqDf-ZCm8vTp_6ERwYSC6Bt2-8r-C2yH9gQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Feb 12, 2018 at 10:35:50AM +0100, Philippe Ombredanne wrote:
> Jerry,
> 
> On Mon, Feb 12, 2018 at 6:21 AM, Jerry Hoemann <jerry.hoemann@hpe.com> wrote:
> > Minor white space changes and some name clean up.
> >
> > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> > ---
> >  drivers/watchdog/hpwdt.c | 49 +++++++++++++++++++++++-------------------------
> >  1 file changed, 23 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > index 6f7949ef9a23..ee9a92220ece 100644
> > --- a/drivers/watchdog/hpwdt.c
> > +++ b/drivers/watchdog/hpwdt.c
> > @@ -1,11 +1,9 @@
> >  /*
> >   *     HPE WatchDog Driver
> > - *     based on
> >   *
> > - *     SoftDog 0.05:   A Software Watchdog Device
> > - *
> > - *     (c) Copyright 2015 Hewlett Packard Enterprise Development LP
> > + *     (c) Copyright 2018 Hewlett Packard Enterprise Development LP
> >   *     Thomas Mingarelli <thomas.mingarelli@hpe.com>
> > + *     Jerry Hoemann <jerry.hoemann@hpe.com>
> >   *
> >   *     This program is free software; you can redistribute it and/or
> >   *     modify it under the terms of the GNU General Public License
> 
> Since you are updating the copyright, why not updating the licensing
> to use the new concise SPDX ids instead? [1]
> And you get a big good karma bonus if you can also do the same for all
> HPE-copyrighted files, tree-wide ;) and/or spread the word inside your
> team.
> 

Different logical change, separate patch, please. Which, on a side note,
you might consider submitting yourself.

Thanks,
Guenter
