Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:32793 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbcGINer (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 9 Jul 2016 09:34:47 -0400
Received: by mail-qk0-f178.google.com with SMTP id p74so24649935qka.0
        for <linux-watchdog@vger.kernel.org>; Sat, 09 Jul 2016 06:34:46 -0700 (PDT)
MIME-Version: 1.0
Reply-To: ioanm@linux.com
In-Reply-To: <5780BCF8.8020808@roeck-us.net>
References: <CAH2idReJfXsd3QWvpRKnaLpw_isURt2p81VdGpPEU9dPnPHQpA@mail.gmail.com>
 <577E71D0.3030207@roeck-us.net> <CAH2idRciNOYZ9x8HC6oJM77pfJ2V93eamSxxpGMe_gtQOoyi2Q@mail.gmail.com>
 <20160707191600.GA9431@roeck-us.net> <CAH2idRff1LPQmLiA60HbQkE27CMUPan0N3wHoSCvAsfZoCvHww@mail.gmail.com>
 <577FA963.70408@roeck-us.net> <CAH2idRdJ8JGsLYztXQWo4A770zqf5tFoAmam9vahvaSZYr8XCQ@mail.gmail.com>
 <5780BCF8.8020808@roeck-us.net>
From: Ioan Moldovan <ioan.moldovan1999@gmail.com>
Date: Sat, 9 Jul 2016 16:34:45 +0300
Message-ID: <CAH2idReAuQt=N0vM8DLjg1weyb4Qft1wWtSmqAYRs570bQEhzw@mail.gmail.com>
Subject: Re: I/O address 0x0cd6 already in use
To: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

How about reporting this to i2c, and asking the devs there if they
need that I/O Addr.
Maybe this can be patched in 4.6.4 :)
