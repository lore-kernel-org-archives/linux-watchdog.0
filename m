Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:44229 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750799AbdGNIfB (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Jul 2017 04:35:01 -0400
Subject: Re: [PATCH 1/5 v2] Extend the request_region() infrastructure
To: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Christian Fetzer <fetzer.ch@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Tim Small <tim@seoss.co.uk>,
        Guenter Roeck <linux@roeck-us.net>, kernel@ekass.net,
        wim@iguana.be, jlayton@poochiereds.net, marc.2377@gmail.com,
        cshorler@googlemail.com, wsa@the-dreams.de,
        regressions@leemhuis.info,
        Alex Williamson <alex.williamson@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Jakub Sitnicki <jsitnicki@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Guinot <simon.guinot@sequanux.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Travis <travis@sgi.com>,
        Daeseok Youn <daeseok.youn@gmail.com>,
        Huang Rui <ray.huang@amd.com>, Andiry Xu <andiry.xu@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        David Howells <dhowells@redhat.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Alexandre Desnoyers <alex@qtec.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wan ZongShun <Vincent.Wan@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lucas Stach <dev@lynxeye.de>,
        Denis Turischev <denis.turischev@compulab.co.il>
References: <20170621035349.4125-1-zboszor@pr.hu>
 <20170622132134.7200-1-zboszor@pr.hu> <20170622132134.7200-2-zboszor@pr.hu>
From: Boszormenyi Zoltan <zboszor@pr.hu>
Message-ID: <f8e2e529-c07b-baa8-27bd-de1b5b553b8f@pr.hu>
Date: Fri, 14 Jul 2017 10:33:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170622132134.7200-2-zboszor@pr.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

2017-06-22 15:21 keltez=C3=A9ssel, Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi=
 =C3=ADrta:
> Add a new IORESOURCE_ALLOCATED flag that is automatically used
> when alloc_resource() is used internally in kernel/resource.c
> and free_resource() now takes this flag into account.
>=20
> The core of __request_region() was factored out into a new function
> called __request_declared_region() that needs struct resource *
> instead of the (start, n, name) triplet.
>=20
> These changes allow using statically declared struct resource
> data coupled with the pre-existing DEFINE_RES_IO_NAMED() static
> initializer macro. The new macro exploiting
> __request_declared_region() is request_declared_muxed_region()
>=20
> v2:
>=20
> Fixed checkpatch.pl warnings and errors and extended the macro
> API with request_declared_region() and release_declared_region()
>=20
> Reversed the order of __request_declared_region and __request_region
>=20
> Added high level description of the muxed and declared variants
> of the macros.
>=20
> Signed-off-by: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@pr.hu>
> ---
>   include/linux/ioport.h | 14 ++++++++++++++
>   kernel/resource.c      | 40 +++++++++++++++++++++++++++++++++++++---
>   2 files changed, 51 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 6230064..6ebcd39 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -52,6 +52,7 @@ struct resource {
>   #define IORESOURCE_MEM_64	0x00100000
>   #define IORESOURCE_WINDOW	0x00200000	/* forwarded by bridge */
>   #define IORESOURCE_MUXED	0x00400000	/* Resource is software muxed */
> +#define IORESOURCE_ALLOCATED	0x00800000	/* Resource was allocated */
>  =20
>   #define IORESOURCE_EXT_TYPE_BITS 0x01000000	/* Resource extended type=
s */
>   #define IORESOURCE_SYSRAM	0x01000000	/* System RAM (modifier) */
> @@ -215,7 +216,14 @@ static inline bool resource_contains(struct resour=
ce *r1, struct resource *r2)
>  =20
>   /* Convenience shorthand with allocation */
>   #define request_region(start,n,name)		__request_region(&ioport_resour=
ce, (start), (n), (name), 0)
> +#define request_declared_region(res)		__request_region( \
> +							&ioport_resource, \
> +							(res), 0)
>   #define request_muxed_region(start,n,name)	__request_region(&ioport_r=
esource, (start), (n), (name), IORESOURCE_MUXED)
> +#define request_declared_muxed_region(res)	__request_declared_region( =
\
> +							&ioport_resource, \
> +							(res), \
> +							IORESOURCE_MUXED)
>   #define __request_mem_region(start,n,name, excl) __request_region(&io=
mem_resource, (start), (n), (name), excl)
>   #define request_mem_region(start,n,name) __request_region(&iomem_reso=
urce, (start), (n), (name), 0)
>   #define request_mem_region_exclusive(start,n,name) \
> @@ -227,8 +235,14 @@ extern struct resource * __request_region(struct r=
esource *,
>   					resource_size_t n,
>   					const char *name, int flags);
>  =20
> +extern struct resource *__request_declared_region(struct resource *par=
ent,
> +					struct resource *res, int flags);
> +
>   /* Compatibility cruft */
>   #define release_region(start,n)	__release_region(&ioport_resource, (s=
tart), (n))
> +#define release_declared_region(res)	__release_region(&ioport_resource=
, \
> +						(res)->start, \
> +						(res)->end - (res)->start + 1)
>   #define release_mem_region(start,n)	__release_region(&iomem_resource,=
 (start), (n))
>  =20
>   extern void __release_region(struct resource *, resource_size_t,
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 9b5f044..2be7029 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -184,6 +184,9 @@ static void free_resource(struct resource *res)
>   	if (!res)
>   		return;
>  =20
> +	if (!(res->flags & IORESOURCE_ALLOCATED))
> +		return;
> +
>   	if (!PageSlab(virt_to_head_page(res))) {
>   		spin_lock(&bootmem_resource_lock);
>   		res->sibling =3D bootmem_resource_free;
> @@ -210,6 +213,8 @@ static struct resource *alloc_resource(gfp_t flags)
>   	else
>   		res =3D kzalloc(sizeof(struct resource), flags);
>  =20
> +	res->flags =3D IORESOURCE_ALLOCATED;
> +
>   	return res;
>   }
>  =20
> @@ -1110,8 +1115,19 @@ resource_size_t resource_alignment(struct resour=
ce *res)
>    * the IO flag meanings (busy etc).
>    *
>    * request_region creates a new busy region.
> + * The resource descriptor is allocated by this function.
> + *
> + * request_declared_region creates a new busy region
> + * described in an existing resource descriptor.
> + *
> + * request_muxed_region creates a new shared busy region.
> + * The resource descriptor is allocated by this function.
> + *
> + * request_declared_muxed_region creates a new shared busy region
> + * described in an existing resource descriptor.
>    *
>    * release_region releases a matching busy region.
> + * The region is only freed if it was allocated.
>    */
>  =20
>   static DECLARE_WAIT_QUEUE_HEAD(muxed_resource_wait);
> @@ -1128,7 +1144,6 @@ struct resource * __request_region(struct resourc=
e *parent,
>   				   resource_size_t start, resource_size_t n,
>   				   const char *name, int flags)
>   {
> -	DECLARE_WAITQUEUE(wait, current);
>   	struct resource *res =3D alloc_resource(GFP_KERNEL);
>  =20
>   	if (!res)
> @@ -1138,6 +1153,26 @@ struct resource * __request_region(struct resour=
ce *parent,
>   	res->start =3D start;
>   	res->end =3D start + n - 1;
>  =20
> +	if (!__request_declared_region(parent, res, flags)) {
> +		free_resource(res);
> +		res =3D NULL;
> +	}
> +
> +	return res;
> +}
> +EXPORT_SYMBOL(__request_region);
> +
> +/**
> + * __request_declared_region - create a new busy resource region
> + * @parent: parent resource descriptor
> + * @res: child resource descriptor
> + * @flags: IO resource flags
> + */
> +struct resource *__request_declared_region(struct resource *parent,
> +				   struct resource *res, int flags)
> +{
> +	DECLARE_WAITQUEUE(wait, current);
> +
>   	write_lock(&resource_lock);
>  =20
>   	for (;;) {
> @@ -1166,14 +1201,13 @@ struct resource * __request_region(struct resou=
rce *parent,
>   			continue;
>   		}
>   		/* Uhhuh, that didn't work out.. */
> -		free_resource(res);
>   		res =3D NULL;
>   		break;
>   	}
>   	write_unlock(&resource_lock);
>   	return res;
>   }
> -EXPORT_SYMBOL(__request_region);
> +EXPORT_SYMBOL(__request_declared_region);
>  =20
>   /**
>    * __release_region - release a previously reserved resource region
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
