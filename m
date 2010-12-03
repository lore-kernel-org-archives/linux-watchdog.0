Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:54507 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606Ab0LCTjv (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 Dec 2010 14:39:51 -0500
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oB3JNKdN030269
	for <linux-watchdog@vger.kernel.org>; Fri, 3 Dec 2010 14:23:20 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 42B23728059
	for <linux-watchdog@vger.kernel.org>; Fri,  3 Dec 2010 14:39:50 -0500 (EST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id oB3Jdntl186256
	for <linux-watchdog@vger.kernel.org>; Fri, 3 Dec 2010 14:39:49 -0500
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id oB3JdmYQ020943
	for <linux-watchdog@vger.kernel.org>; Fri, 3 Dec 2010 12:39:49 -0700
Date: Fri, 3 Dec 2010 14:39:01 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Cc: linux-watchdog@vger.kernel.org, kumar.gala@freescale.com,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] watchdog: add CONFIG_WATCHDOG_NOWAYOUT support to
 PowerPC Book-E watchdog driver
Message-ID: <20101203193900.GC1903@zod.rchland.ibm.com>
References: <1291395103-12394-1-git-send-email-timur@freescale.com>
 <20101203180751.GA1903@zod.rchland.ibm.com>
 <4CF93566.1050601@freescale.com>
 <20101203190556.GB1903@zod.rchland.ibm.com>
 <4CF9408A.4030506@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CF9408A.4030506@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Dec 03, 2010 at 01:10:02PM -0600, Timur Tabi wrote:
>> I guess I don't really care either way if multiple processes have the
>> device open, as long as none of them can "disable" the watchdog if
>> NOWAYOUT is set.
>
>Well, this patch takes care of that problem.
>
>So just to be clear, do you still have any issues with my patch?

Just the moving of the clear_bit inside the #ifndef
CONFIG_WATCHDOG_NOWAYOUT.

josh
