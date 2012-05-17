Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64999 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760893Ab2EQON3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 17 May 2012 10:13:29 -0400
Received: by obbtb18 with SMTP id tb18so2557384obb.19
        for <linux-watchdog@vger.kernel.org>; Thu, 17 May 2012 07:13:29 -0700 (PDT)
Message-ID: <4FB50780.3020904@landley.net>
Date: Thu, 17 May 2012 09:13:20 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
To: Devendra Naga <devendra.aaru@gmail.com>
CC: linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/watchdog: Fix the file descriptor leak
 when no cmdline arg given
References: <1337247411-28082-1-git-send-email-devendra.aaru@gmail.com>
In-Reply-To: <1337247411-28082-1-git-send-email-devendra.aaru@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/17/2012 04:36 AM, Devendra Naga wrote:
> we start a infinite loop when user gives ./watchdog-test, and when user
> ctrl + c's the program, we just exit immeadiately with out closing the
> filedescriptor of the watchdog device. a signal handler is used to
> do the job of closing the filedescriptor and exiting the program.

Doesn't exiting a process close all its filehandles already?

Rob
-- 
GNU/Linux isn't: Linux=GPLv2, GNU=GPLv3+, they can't share code.
Either it's "mere aggregation", or a license violation.  Pick one.
