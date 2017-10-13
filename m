Return-Path: <rrendec@arista.com>
Return-path: <rrendec@arista.com>
Message-ID: <1507891573.4735.55.camel@arista.com>
Subject: Re: Lowering the log level in watchdog_dev_register when err==-EBUSY
From: Radu Rendec <rrendec@arista.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Fri, 13 Oct 2017 11:46:13 +0100
In-Reply-To: <20171012195401.GA25996@roeck-us.net>
References: <1507743991.3486.5.camel@arista.com>
	 <20171011184603.GB8756@roeck-us.net> <1507832159.4735.47.camel@arista.com>
	 <20171012195401.GA25996@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, 2017-10-12 at 12:54 -0700, Guenter Roeck wrote:
> On Thu, Oct 12, 2017 at 07:15:59PM +0100, Radu Rendec wrote:
> > Thanks for the suggestion! That makes sense. I will start working on
> > converting i6300esb and submit a patch in a few days.
> > 
> > By the way, I don't have the hardware. I'm using it with KVM (Qemu),
> > but I guess that's good enough since I'm not going to touch any of the
> > code parts that deal with the hardware.
> > 
> 
> Ah, interesting. Can you send me the qemu command line ?

Sure, this is as easy as adding "-device i6300esb" to the qemu command
line.

For what is worth, my full command line is:

qemu-system-i386 \
	-enable-kvm \
	-hda fed26.qcow2 \
	-cdrom ~/Downloads/Fedora-Everything-netinst-i386-26-1.5.iso \
	-m 512 \
	-smp 4 \
	-netdev user,id=net0 \
	-netdev tap,id=net1,br=virbr0,helper=/usr/libexec/qemu-bridge-helper \
	-device e1000,netdev=net0 \
	-device e1000,netdev=net1 \
	-device i6300esb

Thanks,
Radu
