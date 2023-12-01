Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="It/jmjCg"
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BEC10E4
	for <linux-watchdog@vger.kernel.org>; Fri,  1 Dec 2023 12:25:25 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so694585a12.3
        for <linux-watchdog@vger.kernel.org>; Fri, 01 Dec 2023 12:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701462325; x=1702067125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srxzfUuXBFkMVOn7OGaNdyaL+KSIWUVGXnTpFNQ9fis=;
        b=It/jmjCg6qSzDVE/pAJ6hEk5g1Fk1ppJxx9o+8N5AXfwTq5UWAC/14YXIwxAD3lwnk
         hW9L0wQ0HqztDtqBVJqqNGEpHVbnTdztR7WJ4GaYgarjAMorImA821lSHTQ4pPAVJClU
         VLbM97OlE235JQY8pPKCF1pN6Zha9bkPKjP4dwiN25tXGsyEiSGQqsKDkA9ODuKykJ8a
         VTYTOausGpADocJzHiKdunmthVmGPmJY0i+HLtwE41u+geamXwxAMAPZyggVRhTMW9Zg
         Z/w23fM7wEA7yaTw8pqgD+0UITZzFGvf7RoM1lWtT6ZkFQcVmz2TMeDp0V6PfXidbSWy
         x6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701462325; x=1702067125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srxzfUuXBFkMVOn7OGaNdyaL+KSIWUVGXnTpFNQ9fis=;
        b=MKhHOopVImvcb2sFjod+ydvmgy22toumW/W1uAOl+pt/Waj+Yb/Q27Hn8cUMOSFQxj
         Khno9DKZZOK5BTrGdcenvE46gaEjsZEJehPCBp8AX+b8dsZJLEQJMmsUloSNhM1vHjCX
         zrRQMIkc9PvbxNnslIdnT2rn26Mh3dGUgpY527ekJgBXmacqR0yEcmhWQs9WNeRFxVzB
         2WzWzAsYSGCXxBgTkoFnuj/r2SoJ4emzPuPjtf+t72AQiybFMP3H6Y3qA/pU/GEbDsPD
         rgGmikYa6b8enZJTr8kBG+Wu0uqbKoQ5LbMZ2ZWR7I5WplXnZvEH0Q+wNQCZ5Sv75cGg
         hOQg==
X-Gm-Message-State: AOJu0YwOsRsOE3lqd9Kn3e/uGFRXRoElWqvxdHxKI72ao17p9ocD/sj9
	MXA7ZFGloDPHTJQEYSmgIhnU9Cb7oJxvnhVk0PT6jg==
X-Google-Smtp-Source: AGHT+IGhcjjItpFP1S8xXsF49mbnFTtcjlU4G86zhv4yaAeBkLj2OCa5brrLkR7NmAsB4hi8jkTN6iLwfS0jbWLoyLw=
X-Received: by 2002:a17:90b:4a92:b0:285:adb0:de3e with SMTP id
 lp18-20020a17090b4a9200b00285adb0de3emr93998pjb.34.1701462324828; Fri, 01 Dec
 2023 12:25:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201160925.3136868-1-peter.griffin@linaro.org> <20231201160925.3136868-8-peter.griffin@linaro.org>
In-Reply-To: <20231201160925.3136868-8-peter.griffin@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 1 Dec 2023 14:25:13 -0600
Message-ID: <CAPLW+4kMHhh2++F9pU3VSxBo9H-r+79XB8eSc9yi+DR48C=8vQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/20] dt-bindings: pinctrl: samsung: add
 gs101-wakeup-eint compatible
To: Peter Griffin <peter.griffin@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org, 
	tomasz.figa@gmail.com, s.nawrocki@samsung.com, linus.walleij@linaro.org, 
	wim@linux-watchdog.org, linux@roeck-us.net, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, olof@lixom.net, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, saravanak@google.com, 
	willmcvicker@google.com, soc@kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, kernel-team@android.com, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 10:10=E2=80=AFAM Peter Griffin <peter.griffin@linaro=
.org> wrote:
>
> gs101 is similar to newer Exynos SoCs like Exynos850 and ExynosAutov9
> where more than one pin controller can do external wake-up interrupt.
> So add a dedicated compatible for it.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  .../bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml      | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wa=
keup-interrupt.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pin=
ctrl-wakeup-interrupt.yaml
> index 2bafa867aea2..de2209f8ba00 100644
> --- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-in=
terrupt.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-in=
terrupt.yaml
> @@ -44,6 +44,7 @@ properties:
>            - const: samsung,exynos7-wakeup-eint
>        - items:
>            - enum:
> +              - google,gs101-wakeup-eint
>                - samsung,exynosautov9-wakeup-eint
>                - samsung,exynosautov920-wakeup-eint
>            - const: samsung,exynos850-wakeup-eint

(to myself): I wonder why exynos850 isn't in the enum above.

> @@ -111,6 +112,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - google,gs101-wakeup-eint
>                - samsung,exynos850-wakeup-eint
>      then:
>        properties:
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
