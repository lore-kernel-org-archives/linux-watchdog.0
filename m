Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337145;
	b=CSaHDmoe8to8Aayov8s0bhezAnzyosziFPeRPZzNdfd9GyMw/K3tKjjeTAcBIrk3DKg+
	 A23U3DvhrMEZ4TUSaXwVygRMSBWSKAYRAAwaGY0yNJ2U1QplH9fSK92qrj+dDSVhk5spa
	 EtdcIFpK8jgpd5WY9i3L54qlLeNirH3BjgRj0dUHT//0v5GVocuSrGaCxdpQsJ8EbV9U7
	 hzhmWq2L6dhQx8qQJWdu8qbfY5g1Oes/Wthp+iASw2RNHbG7AJ8Ic+rlscjiPJEz/gQMk
	 dyIn0BAearVKZpmZe+3W6/pyS3S2ndpKt0qq7k336lgK/kYB9vzMS/7bx4sMsmZGksw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337145;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3+Ll2YF7cP/FlHHtxkvTmmRg2Zv+2hxybwAXwgDSfLg=;
	b=NaqQ3s1HbYFXGBJbq+M+EKDMicZaqxOwaagz5y71MLK+EXZfSPmk7dcw4ujoIr588P+B
	 UsG3PwSn63EC8hOTwcrVJ5qkYfQ6rWYn/RgZlnNhy556XZ+cDXi1m2hpGGDT2vAMaeNrU
	 4AoVY9QWLQBtT57RfQx9deoVGRgGR+Oz6PQ2mqq1ZmPZp1bpcA/t8pTU9ytH2syLDD5kU
	 VGBFk/LnRjh5VhWnvZSC92VFkLBPeyd3mi4L0X6j632/6Ty2fqOyN7Mlo1/U2386HJTa5
	 IOmo0oGutrpzF0z2wCfBxrkhCIjd1ZdT5A7DubU6SrSLMCmrUxAdzMvZuOCaXoPO5+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSN1TWvs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86D5606A320;
	Tue, 10 Nov 2026 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSN1TWvs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847051F008A1;
	Tue, 10 Nov 2026 18:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337144;
	bh=3+Ll2YF7cP/FlHHtxkvTmmRg2Zv+2hxybwAXwgDSfLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nSN1TWvsgJIFATur6WlNmPE/Ea6BhJ013bSAFHPeOyu++ooRpdmgP7xOB6smAQvlN
	 ZOtPn6HuilVksOwLYRCHRY0/Pe3aPQFWAgT9cGimnbJQ9ousI3NgIjQpt8THcyr4qm
	 FcuswLkBGa16w6X8xsWgerGCLoi4B/hZ71XLUDAlQe5IrOkEE6uCcHpoLOCzQgUU2Z
	 uPNiNrRARLit1QOjTL4u/69xu1Ev1QJsvSAppIn4vCli1BJR4VjN6XOwOFHMNwP4AU
	 SmqmhMGHUXxARA2xBDpgGwfItlAg4mDpR9+9oWDiB+tDWKr9/OZlDEAPDJ3nzN2vCo
	 j0E62NYSCBClA==
Date: Tue, 10 Nov 2026 18:58:59 +0000
From: Conor Dooley <conor@kernel.org>
To: Rong Zhang <rongrong@oss.cipunited.com>
Cc: Keguang Zhang <keguang.zhang@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rong Zhang <i@rong.moe>, Yao Zi <me@ziyao.cc>,
	Icenowy Zheng <uwu@icenowy.me>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: watchdog: loongson,ls1x-wdt: Add
 ls7a-wdt compatible
Message-ID: <20261110-barterer-pandemic-e4c658cac7c4@spud>
References: <20261110-mips-ls7a-wdt-v1-0-968bb85122e6@oss.cipunited.com>
 <20261110-mips-ls7a-wdt-v1-1-968bb85122e6@oss.cipunited.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DcPnR+w8m8amSTyQ"
Content-Disposition: inline
In-Reply-To: <20261110-mips-ls7a-wdt-v1-1-968bb85122e6@oss.cipunited.com>

--DcPnR+w8m8amSTyQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 03:02:30PM +0800, Rong Zhang wrote:
> The Loongson-7A has a watchdog, which is similar to Loongson 2K0300,
> except that it has no clock controller.

I find this hard to believe, the device seems to be getting a clock from
somewhere that the clock-frequency property is providing the rate of.

Why is that clock not represented in devicetree?

Confused,
Conor.

>=20
> Add "loongson,ls7a-wdt" compatible as well as a conditionally required
> field clock-frequency.
>=20
> Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
> ---
>  .../bindings/watchdog/loongson,ls1x-wdt.yaml       | 31 ++++++++++++++++=
+++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt=
=2Eyaml b/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
> index 50a9b468c4a3..cb93e9578f82 100644
> --- a/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
> @@ -18,6 +18,7 @@ properties:
>        - loongson,ls1b-wdt
>        - loongson,ls1c-wdt
>        - loongson,ls2k0300-wdt
> +      - loongson,ls7a-wdt
> =20
>    reg:
>      maxItems: 1
> @@ -25,13 +26,34 @@ properties:
>    clocks:
>      maxItems: 1
> =20
> +  clock-frequency:
> +    description: Frequency of clock in Hz
> +
>  required:
>    - compatible
>    - reg
> -  - clocks
> =20
>  unevaluatedProperties: false
> =20
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - loongson,ls7a-wdt
> +
> +then:
> +  properties:
> +    clocks: false
> +  required:
> +    - clock-frequency
> +
> +else:
> +  properties:
> +    clock-frequency: false
> +  required:
> +    - clocks
> +
>  examples:
>    - |
>      #include <dt-bindings/clock/loongson,ls1x-clk.h>
> @@ -41,3 +63,10 @@ examples:
> =20
>          clocks =3D <&clkc LS1X_CLKID_APB>;
>      };
> +
> +  - |
> +    watchdog@100d0030 {
> +        compatible =3D "loongson,ls7a-wdt";
> +        reg =3D <0x100d0030 0xc>;
> +        clock-frequency =3D <50000000>;
> +    };
>=20
> --=20
> 2.55.0

--DcPnR+w8m8amSTyQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavNpcwAKCRB4tDGHoIJi
0rRaAQCsd/xFDmpZxHcOoc6LRDHiAbgMmTxm6UJYk4dulCZVjAEAuwdw4mSAb9Vw
TPUtVK7itzEhmaBrdgGu4P471tUx6gs=
=S73F
-----END PGP SIGNATURE-----

--DcPnR+w8m8amSTyQ--
