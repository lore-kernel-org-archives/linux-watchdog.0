Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:60995 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbaEBXUu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 2 May 2014 19:20:50 -0400
Received: by mail-pd0-f172.google.com with SMTP id g10so5305394pdj.17
        for <linux-watchdog@vger.kernel.org>; Fri, 02 May 2014 16:20:49 -0700 (PDT)
Date: Fri, 2 May 2014 16:20:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Corey Minyard <minyard@acm.org>
Cc: Don Zickus <dzickus@redhat.com>,
	openipmi-developer@lists.sourceforge.net,
	linux-watchdog@vger.kernel.org
Subject: Re: ipmi watchdog questions
Message-ID: <20140502232042.GB5157@roeck-us.net>
References: <20140501135832.GE61249@redhat.com>
 <5362E8FA.9050700@acm.org>
 <5362F0B0.4030405@roeck-us.net>
 <5363213D.7060701@acm.org>
 <53639AFF.40206@roeck-us.net>
 <20140502164424.GH198341@redhat.com>
 <5363D34B.9000006@roeck-us.net>
 <20140502174650.GI198341@redhat.com>
 <5364138C.1050208@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5364138C.1050208@acm.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, May 02, 2014 at 04:52:12PM -0500, Corey Minyard wrote:
[ ... ]
> 
> I do agree that the driver should be moved over to use the framework. 
> Implementing read/poll should be easy in the framework.
> 
If it isn't essential, I would prefer to drop it for now.
Otherwise, you'll have to convince Wim to accept it.
I am personally not convinced that it is worthwhile.
Eother case, the core changes should be a separate patch
(or set of patches), so the work can be independent of each other.

[ We might want to explore if a sysfs attribute would make more sense
  than the poll/fasync changes, for example ]

In this context, does the driver have to reside in the ipmi directory ?
It would be better to have it in the watchdog directory; that would ensure
that the watchdog maintainer is involved if there are changes.

Guenter
