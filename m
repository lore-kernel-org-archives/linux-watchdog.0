Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:47401 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753160AbdKNQOe (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Nov 2017 11:14:34 -0500
Received: by mail-pg0-f47.google.com with SMTP id o7so15693906pgc.4
        for <linux-watchdog@vger.kernel.org>; Tue, 14 Nov 2017 08:14:34 -0800 (PST)
Date: Tue, 14 Nov 2017 08:14:32 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Sriram V <vshrirama@gmail.com>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: Watchdog thread activity
Message-ID: <20171114161432.GB19879@roeck-us.net>
References: <CAH9_wROZdDzOLnKAq7rHfsAJN63GUT5VBwv46BGG_MLxv6e7JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH9_wROZdDzOLnKAq7rHfsAJN63GUT5VBwv46BGG_MLxv6e7JQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Nov 14, 2017 at 08:34:03PM +0530, Sriram V wrote:
> Hi,
> 
> I am running Linux along with image processing on my system.
> Most watchdogs i have seen previously, has a 30 second/60 second
> timer. The watchdog we have used currently has a fixed timeout value
> of 1.6 seconds.
> 
> I wanted to check if Linux can pet the watchdog say every 1 second.
> Won't it over-load the system if i used mod_timer/workqueue?
> 
> However, I think, Some activity in the system might cause false-resets
> due to the cpu being busy in other tasks.
> 
> Therefore, i wanted to check what is the safe minimum duration which
> will avoid false-resets.
> 

Why don't you just use the existing watchdog subsystem infrastructure,
which does support that use case ? Do you have any evidence that it fails
under some circumstances ? If so, can you let us know how to trigger that
failure so we can understand it and find a possible fix ?

Thanks,
Guenter
