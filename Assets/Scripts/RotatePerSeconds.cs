
[System.SerializableAttribute]
[UnityEngine.DisallowMultipleComponent]
public sealed class RotatePerSeconds : UnityEngine.MonoBehaviour
{
    [UnityEngine.SerializeField]
    private UnityEngine.Transform m_Transform = default;

    [UnityEngine.SerializeField]
    private UnityEngine.Vector3 m_RotetePerSeconds = default;

    /// <summary>
    /// Update is called every frame, if the MonoBehaviour is enabled.
    /// </summary>
    private void Update()
    {
        var localRotation = m_Transform.localRotation;
        localRotation *= UnityEngine.Quaternion.Euler(
            m_RotetePerSeconds * UnityEngine.Time.deltaTime
        );
        m_Transform.localRotation =  localRotation;
    }

#if UNITY_EDITOR
    /// <summary>
    /// Reset to default values.
    /// </summary>
    private void Reset()
    {
        m_Transform = transform;
    }
#endif
}
