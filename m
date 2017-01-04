Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57681 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753169AbdADALs (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 3 Jan 2017 19:11:48 -0500
Date: Tue, 3 Jan 2017 16:11:45 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "wim@iguana.be" <wim@iguana.be>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Auto-conversion of watchdog drivers to use devm functions
Message-ID: <20170104001145.GA15099@roeck-us.net>
References: <8fb3f1a7-1b72-8da3-adcd-11677c455f82@roeck-us.net>
 <CAHp75VcPRkscW8MaM3-nO-tzJnuC9f2fa3wc6oODo_aq+9Wdcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcPRkscW8MaM3-nO-tzJnuC9f2fa3wc6oODo_aq+9Wdcg@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 04, 2017 at 01:55:39AM +0200, Andy Shevchenko wrote:
> On Mon, Jan 2, 2017 at 1:53 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> > Hi Wim,
> >
> > With heavy support by Julia Lawall, I created a number of coccinelle scripts
> > to auto-convert watchdog platform drivers to use devm functions. The result
> > is quite impressive - many drivers won't even need remove functions anymore
> > after the conversion.
> >
> > Question is now how to submit the patches. There are 12 rule files affecting
> > a total of 62 drivers. Should I submit one patch per driver (62 patches),
> > one patch per rule (12), or one patch per rule file per driver (183) ?
> 
> One per driver.
> 
> > Also, how should I refer to the rules ? The total number of rule lines
> > is more than 1,000, which seems to be a bit much for the commit log (even
> > though not all rules apply to all files).
> 
> No need, perhaps some URL?
> 
Yes, that is what I ended up doing - I created a repository on github and
pushed the semantic patches as well as the scripts used to generate the
actual patches into it. I am going to reference that repository in the
patches, together with a summary of the changes made.

An interesting exercise is to let the semantic patches run on the entire
kernel. It generates almost 1,500 patches.

Thanks,
Guenter
