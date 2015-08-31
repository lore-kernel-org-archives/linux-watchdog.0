Return-path: <panand@redhat.com>
Date: Mon, 31 Aug 2015 10:56:06 +0530
From: Pratyush Anand <panand@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, dyoung@redhat.com, dzickus@redhat.com,
        open list:  ABI/API <linux-api@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [RFC] watchdog: Add watchdog device control through sysfs
 attributes
Message-ID: <20150831052606.GD4660@dhcppc13>
References: <d9ac417a3bc1c6846f1ddfcd3cd07e5a92865c19.1440179209.git.panand@redhat.com>
 <20150829165124.GA22494@roeck-us.net>
 <20150831031141.GC4660@dhcppc13>
 <55E3CDBC.2040109@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55E3CDBC.2040109@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On 30/08/2015:08:45:00 PM, Guenter Roeck wrote:
> On 08/30/2015 08:11 PM, Pratyush Anand wrote:
> >On 29/08/2015:09:51:24 AM, Guenter Roeck wrote:
> >>>* timeout - reads current timeout and writes to program a new timeout.
> >
> >Now, this is the only file which has write permission. I hope, that is fine. Pl
> >let me know if you expected this to be as RO as well.
> >
> Good question. Thinking about it, we should make it read-only. Reason is
> that the application sending the heartbeats would not know about timeout
> changes made through sysfs, which could (and likely would) be fatal.

OK..will change accordingly.

~Pratyush
