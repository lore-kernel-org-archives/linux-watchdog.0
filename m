Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567712;
	b=gCWKdBpYIHyJJIpyPxuAViLfjBdQMOLYvPYw4M8o1ULceWhZabIhNB+lMgpWDrF9n9Hw
	 HRguQHMBmxNU+q/Qloueiw33Mz11VPOZIIke2SWXLJUnU8QJNWgX6G5ywPpqukN6yFOlp
	 PPQcGyjhGbIdT92POfSetHWHivEVtCtBnQUsl9xSXf3hxYIqjAJvCnFOYE+ubn/wpmAYR
	 BQcc335z9qk3O4QT6juCchKbN6zQqA/hs6MxHbJEJKUR7sEdYwxanlqk28i/BRVdDbkPP
	 HCY9uZNYWuqZiypgp19KHMwiBPD3AlDqsLVkAt0ikYNL2ykqHt8Ey3zSPEqEABcVxJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567712;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gnfOWe7URm2R5IEmtcBKYwyWsMV7pkHa5vNwqA64Uu0=;
	b=HPr6OhHM3sAq6ptrsm+mx/aDie0GVzpblJPHcyshtdsLwU64fNyjz/Bx8N0b6tFfOhJM
	 2xF4ow/F7ZLWfwx99Ga3m6530eSXNd8yMuGi/7cKAGXn9WvT0bQwnRkYirougadzB0uX/
	 Vadzq+e16eqhKQvnVga03Nj5ivE+l3Fb8FxhLBVlC2UghQt4Frrlkk2FLRKsGiOyjSo4G
	 Eusi5MvFGyxVpJ4SzmKaljWfKkyn+PI7/td9OLTm2dyQxYVYu9q3yEzQtD948xqX4E93P
	 XAAuj/UHJkFpMtlhoClIEJ587Mes2gTl3+kyXS51Lya6CAtE2o2N9VmTHdxSXul8FyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PETZx7ib;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4EB606A88F;
	Fri, 13 Nov 2026 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PETZx7ib
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3251F000C4;
	Fri, 13 Nov 2026 11:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794567712;
	bh=gnfOWe7URm2R5IEmtcBKYwyWsMV7pkHa5vNwqA64Uu0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PETZx7ibkk9+XutdCS4JCUOUeliH2Y0UwsGLIVmAjcazlKfHYspzRdh+QY4S3eAMc
	 w1VQXYA6b65aZHGKkDHL1hYLddM920ZD53tPRefBdMkSBJ25EhxmKmCNhUjA7MxFej
	 WyifhRd8JVN2ayyK+MfKE3xHtv7mC3MbyH6RJzBcjDI73CuX+igU++l1TIagl7ydIF
	 ZL263VmuraXzDt37VJebss4hUZ+8HA8nk8oxrI3FSkYPV1ttYv63sBGMQyRfQSCjTG
	 x6NxUYQDw3q+hXR+/730vE/mBeT2Tu78GOyoS2uZ8v7nwlA+VSwzA/yn3tZO/VJQYu
	 0AxWVxIkbUzjg==
Message-ID: <sashiko-outbox-212658@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] MIPS: Loongson64: dts: ls7a-pch: Add missing
 #address-cells to interrupt controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rong Zhang" <rongrong@oss.cipunited.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113-mips-ls7a-wdt-v2-3-e8abd6b2f77c@oss.cipunited.com>
References: <20261113-mips-ls7a-wdt-v2-0-e8abd6b2f77c@oss.cipunited.com>
 <20261113-mips-ls7a-wdt-v2-3-e8abd6b2f77c@oss.cipunited.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 11:01:51 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] MIPS: dts: loongson: invalid #address-cells on ls7a-lpc node
--

commit b3cb4b22fb7d7fa764f95bec26fd2bfb7137915e
Author: Rong Zhang <rongrong@oss.cipunited.com>

MIPS: Loongson64: dts: ls7a-pch: Add missing #address-cells to interrupt co=
ntrollers

This commit adds #address-cells =3D <0> properties to the pic and lpc
interrupt-controller nodes in ls7a-pch.dtsi.

> diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/d=
ts/loongson/ls7a-pch.dtsi
> index f304f99946f16..28038b8cdd146 100644
> --- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
> +++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi

[ ... ]

> @@ -26,6 +27,7 @@ lpc: interrupt-controller@10002000 {
>  			interrupt-parent =3D <&pic>;
>  			interrupts =3D <19 IRQ_TYPE_LEVEL_HIGH>;
>  			#interrupt-cells =3D <2>;
> +			#address-cells =3D <0>;
>  		};
> =20
>  		ls7a_uart0: serial@10080000 {

[Severity: Low]
Does adding #address-cells to the lpc node break dtbs_check schema
validation?

Documentation/devicetree/bindings/interrupt-controller/loongson,pch-lpc.yaml
sets additionalProperties: false and does not define #address-cells.
Unlike pic, lpc is not referenced by any interrupt-map property, so dtc's
check_interrupt_map() does not warn about it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-mips-ls7a-=
wdt-v2-0-e8abd6b2f77c@oss.cipunited.com?part=3D3
