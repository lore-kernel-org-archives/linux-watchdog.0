Return-path: <mike.looijmans@topic.nl>
Message-ID: <54894204.4070104@topic.nl>
Date: Thu, 11 Dec 2014 08:04:36 +0100
From: Mike Looijmans <mike.looijmans@topic.nl>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] gpio_wdt: Add "always_running" feature to GPIO watchdog
References: <546EE991.1080704@roeck-us.net> <1416562828-3978-1-git-send-email-mike.looijmans@topic.nl>
In-Reply-To: <1416562828-3978-1-git-send-email-mike.looijmans@topic.nl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

=EF=BB=BFIs this v3 patch okay or are you waiting for additional changes?

Kind regards,
Mike.

On 11/21/2014 10:40 AM, Mike Looijmans wrote:
> On some chips, like the TPS386000, the trigger cannot be disabled
> and the CPU must keep toggling the line at all times. Add a switch
> "always_running" to keep toggling the GPIO line regardless of the
> state of the soft part of the watchdog. The "armed" member keeps
> track of whether a timeout must also cause a reset.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> v3: Indentation adjusted to match
> Fix error path in probe when notification registration fails
> Prevent double assignment of "armed" variable
>
>   .../devicetree/bindings/watchdog/gpio-wdt.txt      |    5 +++
>   drivers/watchdog/gpio_wdt.c                        |   39 +++++++++++++=
+++----
>   2 files changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt b/Do=
cumentation/devicetree/bindings/watchdog/gpio-wdt.txt
> index 37afec1..1987949 100644
> --- a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
> @@ -13,6 +13,11 @@ Required Properties:
>       by the GPIO flags.
>   - hw_margin_ms: Maximum time to reset watchdog circuit (milliseconds).
>
> +Optional Properties:
> +- always-running: If the watchdog timer cannot be disabled, add this fla=
g to
> +  have the driver keep toggling the signal without a client. It will onl=
y cease
> +  to toggle the signal when the device is open and the timeout elapsed.
> +
>   Example:
>   	watchdog: watchdog {
>   		/* ADM706 */
> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> index 220a9e0..9bfbd73 100644
> --- a/drivers/watchdog/gpio_wdt.c
> +++ b/drivers/watchdog/gpio_wdt.c
> @@ -31,6 +31,8 @@ struct gpio_wdt_priv {
>   	int			gpio;
>   	bool			active_low;
>   	bool			state;
> +	bool			always_running;
> +	bool			armed;
>   	unsigned int		hw_algo;
>   	unsigned int		hw_margin;
>   	unsigned long		last_jiffies;
> @@ -48,10 +50,8 @@ static void gpio_wdt_disable(struct gpio_wdt_priv *pri=
v)
>   		gpio_direction_input(priv->gpio);
>   }
>
> -static int gpio_wdt_start(struct watchdog_device *wdd)
> +static void gpio_wdt_start_impl(struct gpio_wdt_priv *priv)
>   {
> -	struct gpio_wdt_priv *priv =3D watchdog_get_drvdata(wdd);
> -
>   	priv->state =3D priv->active_low;
>   	gpio_direction_output(priv->gpio, priv->state);
>   	priv->last_jiffies =3D jiffies;
> @@ -60,12 +60,25 @@ static int gpio_wdt_start(struct watchdog_device *wdd=
)
>   	return 0;
>   }
>
> +static int gpio_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct gpio_wdt_priv *priv =3D watchdog_get_drvdata(wdd);
> +
> +	gpio_wdt_start_impl(priv);
> +	priv->armed =3D true;
> +
> +	return 0;
> +}
> +
>   static int gpio_wdt_stop(struct watchdog_device *wdd)
>   {
>   	struct gpio_wdt_priv *priv =3D watchdog_get_drvdata(wdd);
>
> -	mod_timer(&priv->timer, 0);
> -	gpio_wdt_disable(priv);
> +	priv->armed =3D false;
> +	if (!priv->always_running) {
> +		mod_timer(&priv->timer, 0);
> +		gpio_wdt_disable(priv);
> +	}
>
>   	return 0;
>   }
> @@ -91,8 +104,8 @@ static void gpio_wdt_hwping(unsigned long data)
>   	struct watchdog_device *wdd =3D (struct watchdog_device *)data;
>   	struct gpio_wdt_priv *priv =3D watchdog_get_drvdata(wdd);
>
> -	if (time_after(jiffies, priv->last_jiffies +
> -		       msecs_to_jiffies(wdd->timeout * 1000))) {
> +	if (priv->armed && time_after(jiffies, priv->last_jiffies +
> +				      msecs_to_jiffies(wdd->timeout * 1000))) {
>   		dev_crit(wdd->dev, "Timer expired. System will reboot soon!\n");
>   		return;
>   	}
> @@ -197,6 +210,9 @@ static int gpio_wdt_probe(struct platform_device *pde=
v)
>   	/* Use safe value (1/2 of real timeout) */
>   	priv->hw_margin =3D msecs_to_jiffies(hw_margin / 2);
>
> +	priv->always_running =3D of_property_read_bool(pdev->dev.of_node,
> +						     "always-running");
> +
>   	watchdog_set_drvdata(&priv->wdd, priv);
>
>   	priv->wdd.info		=3D &gpio_wdt_ident;
> @@ -216,8 +232,15 @@ static int gpio_wdt_probe(struct platform_device *pd=
ev)
>   	priv->notifier.notifier_call =3D gpio_wdt_notify_sys;
>   	ret =3D register_reboot_notifier(&priv->notifier);
>   	if (ret)
> -		watchdog_unregister_device(&priv->wdd);
> +		goto error_unregister;
>
> +	if (priv->always_running)
> +		gpio_wdt_start_impl(priv);
> +
> +	return 0;
> +
> +error_unregister:
> +	watchdog_unregister_device(&priv->wdd);
>   	return ret;
>   }
>
>



Met vriendelijke groet / kind regards,

Mike Looijmans
System Expert


TOPIC Embedded Systems
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: (+31) (0) 499 33 69 79
Telefax:  (+31) (0) 499 33 69 70
E-mail: mike.looijmans@topic.nl
Website: www.topic.nl

Please consider the environment before printing this e-mail

Topic zoekt gedreven (embedded) software specialisten!
http://topic.nl/vacatures/topic-zoekt-software-engineers/
