Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBC433D506
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 21:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785448080; cv=none; b=TFQj1xV79BWTk5CwYktYRATTGfUbUjN+4KWaRj3JTwAyUeE5liVW6mSYNABPP1q1+c/K6+OuXSSEcbd+ogae8oqUIpUGyUevOGO8nSYXqQaKH+v8hhJCN0SmrQQURnjoHE0e2QZOA3kGVmvxsKNP3q7HO8jQ0WjI996gE/fkDZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785448080; c=relaxed/simple;
	bh=tQ44l2vaDuHIpYAIuOVt7nMqRpKW8dXOcAadQcl35Hk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y3tqccTC4DGu6QGmPW+nnSqafL4sYKtwjL2NZ0co8uKc2W6TBPsg19B46FMPf40aQIIFz0TD2ywrN1HAWJcwBhM0kpUjKDYU6rNK525fsJg1uhtM0FfL9p02ITn4hML2PuiEQQbyd1GdrRpSIdo+FW1+1uWBTxLHmuAkSoqcpYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doU4+rV4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doU4+rV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD5E1F000E9;
	Thu, 30 Jul 2026 21:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785448079;
	bh=oXr3yxNDv/m5cN1hEq6rNBagk5kXIIgLrIvSGWTKHaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=doU4+rV4oKiY0gi3xhDleJ17cl8rEhctbf6aID89uezf6vSvsAKDw8E9vx7lFdI8o
	 rRi7HYWWjmpK2Av5xKcYxkHb4yQhGWEv1hUfWl4HuT1DXeReKfsJsIT3/1SHEEXmoQ
	 r2iUPFc6x6Cj59ohfqv2eMagec1G692iId0Wb276q/nsVyxqcbuMPYog8ODj9VSBCI
	 3YYMWfNpfR9RsIuDUW/sEioJfVEgQn+ax/oAQtOXDd3Qu3VM3GFPbvtl6EolHeUVAV
	 O0qaj3frxqNNXKMX86K4uSrJDYpfa+hlpMrRypnUOhcxT16naFhZF3C5mV4ywHAPLG
	 jXv87T3Us6ziQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] genirq: Export NMI APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mayank Rungta" <mrungta@google.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260730-qcom-wdt-nmi-series-v1-2-3aa86d162914@google.com>
References: <20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com>
 <20260730-qcom-wdt-nmi-series-v1-2-3aa86d162914@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 21:47:58 +0000
Message-Id: <20260730214758.DBD5E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Exporting NMI APIs to loadable modules exposes an unmitigated =
Use-After-Free and kernel panic during module unload due to the lack of NMI=
 synchronization.
- [High] Lack of request_mutex locking in free_nmi() and the request_nmi() =
error path leads to data races, resource double-frees, and refcount underfl=
ows.
--

--- Patch [2]: [PATCH 2/3] genirq: Export NMI APIs ---
commit dfe5c7d2a97396d411087d0eb1dca59bbf190e69
Author: Mayank Rungta <mrungta@google.com>

genirq: Export NMI APIs

Currently, request_nmi(), free_nmi(), enable_nmi() and disable_nmi_nosync()
are restricted to built-in kernel code because they are not exported to
loadable modules. Export these APIs to allow loadable modules to register
and manage NMIs.

> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 2fbff2618a1e2..fb0b8da32f4c1 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
[ ... ]
> @@ -2080,6 +2082,7 @@ const void *free_nmi(unsigned int irq, void *dev_id)
> =20
>  	return __cleanup_nmi(irq, desc);
>  }
> +EXPORT_SYMBOL_GPL(free_nmi);

[Severity: Critical]
This is a pre-existing issue, but does exporting this API to loadable modul=
es
expose an unmitigated use-after-free and kernel panic during module unload?

When a module unloads and calls free_nmi(), __cleanup_nmi() uninstalls the
handler and calls kfree(action) without waiting for executing NMI handlers =
to
finish, such as via synchronize_rcu():

kernel/irq/manage.c:__cleanup_nmi() {
    ...
    unregister_handler_proc(irq, action);
    kfree(action);
    ...
}

Concurrent NMIs on other CPUs bypass normal IRQ locks and can continue to
execute the handler locklessly:

kernel/irq/chip.c:handle_fasteoi_nmi() {
    ...
    struct irqaction *action =3D desc->action;
    ...
    res =3D action->handler(irq, action->dev_id);
    ...
}

Since the module text section is unmapped upon unload, couldn't an actively
executing concurrent NMI jump into unmapped memory, resulting in a fatal
panic?

[ ... ]
> @@ -2342,6 +2345,7 @@ int request_nmi(unsigned int irq, irq_handler_t han=
dler,
> =20
>  	return retval;
>  }
> +EXPORT_SYMBOL_GPL(request_nmi);

[Severity: High]
This is a pre-existing issue, but do request_nmi() and free_nmi() lack
request_mutex locking around their cleanup paths?

According to IRQ subsystem locking rules, desc->request_mutex serializes
resource allocation and teardown. However, both free_nmi() and the failure
path of request_nmi() invoke __cleanup_nmi() without holding this mutex.

In request_nmi():

kernel/irq/manage.c:request_nmi() {
    ...
    if (retval) {
        __cleanup_nmi(irq, desc);
        return -EINVAL;
    }
    ...
}

Inside __cleanup_nmi(), resource teardowns are executed unconditionally
outside of desc->lock:

kernel/irq/manage.c:__cleanup_nmi() {
    ...
    irq_release_resources(desc);
    irq_chip_pm_put(&desc->irq_data);
    module_put(desc->owner);
    ...
}

If request_nmi() fails concurrently with another request_nmi() or free_nmi(=
),
won't this lead to resource double-frees and unbalanced reference counts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-qcom-wdt-n=
mi-series-v1-0-3aa86d162914@google.com?part=3D2
