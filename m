Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuahkh@osg.samsung.com>
CC: "Dutt, Sudeep" <sudeep.dutt@intel.com>,
        "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "wim@iguana.be" <wim@iguana.be>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "elfring@users.sourceforge.net" <elfring@users.sourceforge.net>,
        "nicolas.dichtel@6wind.com" <nicolas.dichtel@6wind.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Chandramouli, Dasaratharaman"
        <dasaratharaman.chandramouli@intel.com>,
        "maheshkhanwalkar@gmail.com" <maheshkhanwalkar@gmail.com>,
        "mikedanese@google.com" <mikedanese@google.com>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        "ghackmann@google.com" <ghackmann@google.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pcmcia@lists.infradead.org" <linux-pcmcia@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH 5/8] samples: move misc-devices/mei example code from
 Documentation
Date: Tue, 20 Sep 2016 06:17:40 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B542EB8FE@hasmsx108.ger.corp.intel.com>
References: <cover.1474073857.git.shuahkh@osg.samsung.com>
        <12a2016ad44adcfb88f442923411f3345b5b3a1e.1474073857.git.shuahkh@osg.samsung.com>
 <20160919101348.1eb53045@lwn.net>
In-Reply-To: <20160919101348.1eb53045@lwn.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>



> -----Original Message-----
> From: Jonathan Corbet [mailto:corbet@lwn.net]
> Sent: Monday, September 19, 2016 19:14
> To: Shuah Khan <shuahkh@osg.samsung.com>
> Cc: Dutt, Sudeep <sudeep.dutt@intel.com>; Dixit, Ashutosh
> <ashutosh.dixit@intel.com>; Winkler, Tomas <tomas.winkler@intel.com>;
> tglx@linutronix.de; wim@iguana.be; linux@roeck-us.net;
> elfring@users.sourceforge.net; nicolas.dichtel@6wind.com;
> davem@davemloft.net; gregkh@linuxfoundation.org; Chandramouli,
> Dasaratharaman <dasaratharaman.chandramouli@intel.com>;
> maheshkhanwalkar@gmail.com; mikedanese@google.com;
> ben@decadent.org.uk; ghackmann@google.com; linux-doc@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-pcmcia@lists.infradead.org; linux-
> watchdog@vger.kernel.org
> Subject: Re: [PATCH 5/8] samples: move misc-devices/mei example code
> from Documentation
> 
> On Mon, 19 Sep 2016 08:47:36 -0600
> Shuah Khan <shuahkh@osg.samsung.com> wrote:
> 
> > Move misc-devices/mei examples to samples/mei and remove it from
> > Documentation Makefile. Delete misc-devices/Makefile.
> >
> > Create a new Makefile to build samples/mei. It can be built from top
> > level directory or from mei directory:
> 
> This one still has a fair amount of code hiding in the .txt files, but that's a
> separate job.
> 
> Acked-by: Jonathan Corbet <corbet@lwn.net>

Shouldn't  this update also the  MAINTAINERS file?
Tomas
