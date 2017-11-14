Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:46841 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754561AbdKNPEE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Nov 2017 10:04:04 -0500
Received: by mail-ua0-f180.google.com with SMTP id w47so10468299uah.3
        for <linux-watchdog@vger.kernel.org>; Tue, 14 Nov 2017 07:04:04 -0800 (PST)
MIME-Version: 1.0
From: Sriram V <vshrirama@gmail.com>
Date: Tue, 14 Nov 2017 20:34:03 +0530
Message-ID: <CAH9_wROZdDzOLnKAq7rHfsAJN63GUT5VBwv46BGG_MLxv6e7JQ@mail.gmail.com>
Subject: Watchdog thread activity
To: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

I am running Linux along with image processing on my system.
Most watchdogs i have seen previously, has a 30 second/60 second
timer. The watchdog we have used currently has a fixed timeout value
of 1.6 seconds.

I wanted to check if Linux can pet the watchdog say every 1 second.
Won't it over-load the system if i used mod_timer/workqueue?

However, I think, Some activity in the system might cause false-resets
due to the cpu being busy in other tasks.

Therefore, i wanted to check what is the safe minimum duration which
will avoid false-resets.

Thanks,
sriram
