Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:39819 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280Ab1CYXnA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 25 Mar 2011 19:43:00 -0400
Received: from hpaq6.eem.corp.google.com (hpaq6.eem.corp.google.com [172.25.149.6])
	by smtp-out.google.com with ESMTP id p2PNgwc1007985
	for <linux-watchdog@vger.kernel.org>; Fri, 25 Mar 2011 16:42:58 -0700
Received: from gxk22 (gxk22.prod.google.com [10.202.11.22])
	by hpaq6.eem.corp.google.com with ESMTP id p2PNguta004600
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Fri, 25 Mar 2011 16:42:57 -0700
Received: by gxk22 with SMTP id 22so820746gxk.2
        for <linux-watchdog@vger.kernel.org>; Fri, 25 Mar 2011 16:42:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110324133244.acffd99a.randy.dunlap@oracle.com>
References: <20110324133244.acffd99a.randy.dunlap@oracle.com>
From: Mike Waychison <mikew@google.com>
Date: Fri, 25 Mar 2011 16:42:36 -0700
Message-ID: <AANLkTikLSVpw73r_g++_oRs=nTjYf5WmH=XNjjp8o5uo@mail.gmail.com>
Subject: Re: [PATCH] watchdog: fix nv_tco section mismatch
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
	akpm <akpm@linux-foundation.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Mar 24, 2011 at 1:32 PM, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> Fix section mismatch warning:
> Mark the called nv_tco_getdevice() as __devinit, just like its caller.

This looks fine.

I can't seem to reproduce the warning on my end however, compiling
this as a built-in nor as a module.  How do I trigger a difference
between __init and __devinit?
