Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Mingarelli, Thomas" <Thomas.Mingarelli@hp.com>
To: Lars Marowsky-Bree <lmb@suse.com>, "Kani, Toshimitsu" <toshi.kani@hp.com>,
        "wim@iguana.be" <wim@iguana.be>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] hpwdt: Fix kdump issue in hpwdt
Date: Mon, 27 Aug 2012 19:57:13 +0000
Message-ID: <9774516974AF5F4C8A2C3C69CD3412332335313E@G1W3651.americas.hpqcorp.net>
References: <1346093544-12007-1-git-send-email-toshi.kani@hp.com>
 <20120827192227.GJ18709@suse.de>
In-Reply-To: <20120827192227.GJ18709@suse.de>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

The main issue here is when an NMI comes in (which is hpwdt's main focus...to source NMIs and then panic the box) and the system is configured for kdump. We want the kdump to succeed and if the iLO watchdog timer is left alone to keep running, the kdump will not succeed. It will be interrupted by an ASR. This change ensures that the iLO Watchdog timer is always stopped in the booting case (of any kernel) or when an NMI arrives and we are in the process of taking a kdump.


Tom

-----Original Message-----
From: Lars Marowsky-Bree [mailto:lmb@suse.com] 
Sent: Monday, August 27, 2012 2:22 PM
To: Kani, Toshimitsu; wim@iguana.be; linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org; Mingarelli, Thomas; stable@vger.kernel.org
Subject: Re: [PATCH] hpwdt: Fix kdump issue in hpwdt

On 2012-08-27T12:52:24, Toshi Kani <toshi.kani@hp.com> wrote:

> kdump can be interrupted by watchdog timer when the timer is left
> activated on the crash kernel. Changed the hpwdt driver to disable
> watchdog timer at boot-time. This assures that watchdog timer is
> disabled until /dev/watchdog is opened, and prevents watchdog timer
> to be left running on the crash kernel.

How does this protect against the system hanging again in the crash
kernel, or possibly hardware caches to flush more data to shared
storage?

(I'm asking from the perspective of the hpwdt being used as a fencing
mechanism in a cluster setting.)

Or is the argument that it's "very unlikely" that a system in such a
state would not make it far enough into the crash kernel?


Regards,
    Lars

-- 
Architect Storage/HA
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB 21284 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde
